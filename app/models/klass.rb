# frozen_string_literal: true

# == Schema Information
#
# Table name: klasses
#
#  id                 :uuid             not null, primary key
#  deleted_at         :datetime
#  duration           :integer
#  friday             :boolean          default(FALSE)
#  max_students       :integer
#  min_students       :integer          default(0)
#  monday             :boolean          default(FALSE)
#  range_type         :integer
#  saturday           :boolean          default(FALSE)
#  session_range      :integer          default(8)
#  starts_at          :datetime
#  sunday             :boolean          default(FALSE)
#  thursday           :boolean          default(FALSE)
#  tuesday            :boolean          default(FALSE)
#  wednesday          :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  account_id         :uuid             not null
#  attendance_form_id :uuid
#  klass_template_id  :uuid
#  room_id            :uuid
#  teacher_id         :uuid
#
# Indexes
#
#  index_klasses_on_account_id          (account_id)
#  index_klasses_on_attendance_form_id  (attendance_form_id)
#  index_klasses_on_klass_template_id   (klass_template_id)
#  index_klasses_on_room_id             (room_id)
#  index_klasses_on_teacher_id          (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (attendance_form_id => forms.id)
#  fk_rails_...  (klass_template_id => klass_templates.id)
#  fk_rails_...  (room_id => rooms.id)
#  fk_rails_...  (teacher_id => users.id)
#
class Klass < ApplicationRecord
  belongs_to :account
  belongs_to :teacher, optional: true
  belongs_to :room, optional: true
  belongs_to :klass_template, optional: true
  belongs_to :attendance_form, optional: true, class_name: 'Form'

  has_many :klass_forms, dependent: :destroy
  has_many :forms, through: :klass_forms
  # has_many :student_forms, through: :student_classes

  has_many :student_classes, dependent: :destroy
  has_many :students, through: :student_classes
  # has_many :student_forms, through: :student_classes

  has_many :student_forms, dependent: :destroy
  has_many :meetings, dependent: :destroy

  enum :range_type, %i[sessional monthly]

  attr_accessor :skip_validations

  validates :duration, :starts_at, presence: true
  validates :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, inclusion: { in: [true, false] }

  accepts_nested_attributes_for :student_forms, allow_destroy: true, reject_if: :all_blank

  after_create :create_meetings, unless: :skip_validations
  before_validation :set_default_max_student

  def set_default_max_student
    self.max_students ||= 5 if max_students.nil?
  end

  def days_abbr
    (monday ? 'M' : '.') + (tuesday ? 'T' : '.') + (wednesday ? 'W' : '.') + \
      (thursday ? 'T' : '.') + (friday ? 'F' : '.') + (saturday ? 'S' : '.') + \
      (sunday ? 'S' : '.')
  end

  def name
    rclass_time = starts_at.strftime('%H:%M %p')
    class_name = "#{days_abbr} at #{rclass_time}"
    class_name = "#{room.name} on #{class_name}" if room.present?
    class_name = "#{teacher.name} in #{class_name}" if teacher.present?
    class_name
  end

  def short_name
    rclass_time = starts_at.strftime('%-I%p')
    class_name = "#{days_abbr} at #{rclass_time}"
    class_name = "#{room.name} on #{class_name}" if room.present?
    "Class in #{class_name}"
  end

  def calendar_name
    class_name = starts_at.strftime('%I%p').gsub('M', '')
    class_name = "#{class_name}-#{teacher.calendar_name}" if teacher.present?
    class_name = "#{class_name} in #{room.name}" if room.present?
    "#{class_name} on #{days_abbr}"
  end

  def un_assigned_student_classes
    student_classes.where.not(id: student_forms.pluck(:student_class_id))
  end

  def assigned_student_classes
    student_classes.where(id: student_forms.pluck(:student_class_id))
  end

  def extended_meeting_dates(limit, starting_date, extend_type = :sessional, vacation_dates = Vacation.all)
    virtual = []

    return virtual if limit.zero?
    return virtual if !sunday && !monday &&
                      !tuesday && !wednesday &&
                      !thursday && !friday &&
                      !saturday

    meetings = self.meetings.order(starts_at: :desc).load

    est_last_date = if meetings.empty?
                      starting_date
                    else
                      [meetings.try(:first).starts_at + 1.day, starting_date].max
                    end

    end_day = est_last_date.to_date + limit.weeks if extend_type == :monthly
    day = est_last_date.to_date

    day_limit = limit
    loop do
      break if extend_type == :sessional && day_limit <= 0
      break if extend_type == :monthly && day >= end_day

      dow = day.days_to_week_start

      if (dow.zero? && !monday) ||
         ((dow == 1) && !tuesday) ||
         ((dow == 2) && !wednesday) ||
         ((dow == 3) && !thursday) ||
         ((dow == 4) && !friday) ||
         ((dow == 5) && !saturday) ||
         ((dow == 6) && !sunday)
        day += 1.day
        next
      end

      vacation_dates = vacation_dates.where(account_id:)

      day_to_check = DateTime.new(
        day.year,
        day.month,
        day.day,
        starting_date.hour,
        starting_date.min,
        starting_date.sec,
        starting_date.zone
      )

      if vacation_dates.select { |x| x.starting_at < day_to_check && day_to_check < x.ending_at }.any?
        day += 1.day
        next
      end

      virtual << day_to_check
      day_limit -= 1
      day += 1.day
    end

    virtual
  end

  def extend_meetings(limit, start_date)
    extended_meeting_dates(limit, start_date).each do |expected_date|
      meetings.create!(starts_at: expected_date, account_id:)
    end
  end

  def create_meetings
    extend_meetings(session_range, starts_at)
  end

  def est_end_date
    meetings.maximum(:starts_at)
  end

  def send_email(options)
    parents = students.map(&:parent).uniq
    parents.notify_all_about_klass(options)
  end

  def self.at(date)
    klass_ids = Meeting.where('date(starts_at) = ?', date).map(&:klass_id)
    all.where(id: klass_ids)
  end
end
