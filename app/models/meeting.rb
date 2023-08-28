# frozen_string_literal: true

# == Schema Information
#
# Table name: meetings
#
#  id           :uuid             not null, primary key
#  cancel       :boolean
#  deleted_at   :datetime
#  ends_at      :datetime
#  hold         :boolean
#  obsolete     :boolean          default(FALSE)
#  obsoleted_at :datetime
#  starts_at    :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :uuid             not null
#  klass_id     :uuid             not null
#
# Indexes
#
#  index_meetings_on_account_id  (account_id)
#  index_meetings_on_klass_id    (klass_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (klass_id => klasses.id)
#
class Meeting < ApplicationRecord
  belongs_to :account
  belongs_to :klass
  has_many :payments, dependent: nil
  has_many :student_meetings, dependent: nil
  has_many :attentive_students, through: :student_meetings, source: 'student'

  ###### Klass associations #####
  delegate :students, to: :klass
  delegate :teacher, to: :klass
  delegate :room, to: :klass
  delegate :meetings, to: :klass
  delegate :student_classes, to: :klass
  delegate :attendance_form, to: :klass
  delegate :forms, to: :klass
  delegate :short_name, to: :klass

  has_many :student_meetings, dependent: :destroy
  has_many :form_details, as: :parent, dependent: nil
  has_many :attentive_students, through: :student_meetings, source: 'student'

  scope :at, ->(date) { where('date(starts_at) = ?', date) }

  scope :obsolete, -> { where obsolete: true }
  scope :working, -> { where obsolete: false }

  validates :starts_at, presence: true
  validates :ends_at, presence: true, date: { after_or_equal_to: :starts_at }

  before_validation :set_end_time
  after_save :handle_obsolete, if: :saved_change_to_obsolete?

  def set_end_time
    self.ends_at = starts_at + klass.duration.minutes
  end

  def self.mark_attendance(date, attendance)
    meets = all.where('starts_at >= ? and starts_at <= ?', date.beginning_of_day, date.end_of_day)
    meets.each do |meet|
      meet.students.each do |student|
        meet.student_meetings
            .find_or_create_by!(account_id: meet.account_id, student:)
            .update(attendance:)
      end
    end
  end

  def self.send_email_for(date, options)
    classes = all.where('date(starts_at) = ?', date).map(&:klass).uniq
    student_ids = StudentClass.where(klass_id: classes).map(&:student_id).uniq
    parents = Parent.joins(:children).where(students: { id: student_ids })
    parents.notify_all_about_klass(options)
  end

  def current_students
    scs_without_deleted_at = student_classes.includes(:student).where('created_at >= ?', starts_at.end_of_day)
    scs_with_deleted_at =  student_classes.with_deleted.includes(:student).where('created_at <= ? and deleted_at >= ?', starts_at, starts_at)

    {
      without_deleted_at: scs_without_deleted_at.map(&:student),
      with_deleted_at: scs_with_deleted_at.map(&:student)
    }
  end

  def self.to_csv(options = {})
    CSV.generate(headers: true) do |csv|
      csv << ['Date:', options[:date]]
      csv << []

      all.find_each do |record|
        csv << [record.klass.name, '', record.starts_at]
        csv << []

        record.form_details.group_by(&:form).each do |form, values|
          csv << ['Form Name', 'Student name', *form.form_fields.order(:id).map(&:name)]
          values.each do |fd|
            csv << [form.name, fd.student.name, *form.form_fields.order(:id).map { |x| fd.form_values[x.model_key] }]
          end
        end
        csv << []
      end
    end
  end

  private

  def handle_obsolete
    MeetingManageObsoleteJob.perform_async(id)
  end
end
