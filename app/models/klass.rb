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
  belongs_to :teacher
  belongs_to :room
  belongs_to :klass_template
  belongs_to :attendance_form, optional: true, class_name: 'Form'

  has_many :klass_forms, dependent: :destroy
  has_many :forms, through: :klass_forms

  has_many :meetings, dependent: :destroy
  has_many :student_classes, dependent: :destroy
  has_many :students, through: :student_classes

  enum :range_type, %i[sessional monthly]

  validates :duration, :starts_at, presence: true
  validates :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, inclusion: { in: [true, false] }

  after_create :create_meetings

  def days_abbr
    (monday ? 'M' : '.') + (tuesday ? 'T' : '.') + (wednesday ? 'W' : '.') + \
      (thursday ? 'T' : '.') + (friday ? 'F' : '.') + (saturday ? 'S' : '.') + \
      (sunday ? 'S' : '.')
  end

  def name
    rclass_time = starts_at.strftime('%H:%M')
    "#{teacher.name} in #{room.name} on #{days_abbr} at #{rclass_time}"
  end

  def short_name
    rclass_time = starts_at.strftime('%H:%M')
    "Class in #{room.name} on #{days_abbr} at #{rclass_time}"
  end

  def extended_meeting_dates(limit, starting_date, extend_type = :sessional, vacation_dates = Vacation.all)
    return if limit.zero?
    return if !sunday && !monday &&
              !tuesday && !wednesday &&
              !thursday && !friday &&
              !saturday

    virtual = []

    meetings = self.meetings.order(starts_at: :desc).load

    est_last_date = if meetings.empty?
                      starting_date
                    else
                      [meetings.try(:first).try(:starts_at).presence, starting_date].max
                    end

    end_day = est_last_date.to_date + limit.weeks if extend_type == :monthly
    day = est_last_date.to_date

    day_limit = limit
    loop do
      break if extend_type == :sessional && day_limit <= 0
      break if extend_type == :monthly && day >= end_day

      day += 1.day

      dow = day.days_to_week_start

      if (dow.zero? && !monday) ||
         ((dow == 1) && !tuesday) ||
         ((dow == 2) && !wednesday) ||
         ((dow == 3) && !thursday) ||
         ((dow == 4) && !friday) ||
         ((dow == 5) && !saturday) ||
         ((dow == 6) && !sunday)
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

      next if vacation_dates.select { |x| x.starting_at < day_to_check && day_to_check < x.ending_at }.any?

      virtual << day_to_check
      day_limit -= 1
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
    klass_ids = Meeting.where(starts_at: date).map(&:klass_id)
    all.where(id: klass_ids)
  end
end
