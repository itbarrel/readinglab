# frozen_string_literal: true

# == Schema Information
#
# Table name: meetings
#
#  id         :uuid             not null, primary key
#  cancel     :boolean
#  deleted_at :datetime
#  ends_at    :datetime
#  hold       :boolean
#  starts_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#  klass_id   :uuid             not null
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
  belongs_to :attendace_form, optional: true, class_name: 'Form'

  ##### All klass students #####
  delegate :students, to: :klass
  delegate :meetings, to: :klass
  delegate :student_classes, to: :klass

  has_many :student_meetings, dependent: :destroy
  has_many :attentive_students, through: :student_meetings, source: 'student'
  # belongs_to :attendance_form, class_name: 'Form', optional: true

  validates :starts_at, presence: true
  validates :ends_at, presence: true, date: { after_or_equal_to: :starts_at }

  before_validation :set_end_time

  def set_end_time
    self.ends_at = starts_at + klass.duration.minutes
  end

  def self.mark_attendance(date, attendance)
    meets = all.where('starts_at >= ? and starts_at <= ?', date.beginning_of_day, date.end_of_day)
    meets.each do |meet|
      meet.students.each do |student|
        meet.student_meetings
            .find_or_create_by!(account_id: meet.account_id, student: student)
            .update(attendance: attendance)
      end
    end
  end

  def self.send_email_for(date)
    classes = all.where('date(starts_at) = ?', date).map(&:klass).uniq
    student_ids = StudentClass.where(klass_id: classes).map(&:student_id).uniq
    parents = Parent.joins(:children).where(students: { id: student_ids })
    parents.notify_all_about_klass
  end

  def current_students
    scs = student_classes.includes(:student).where('created_at <= ?',
                                                   starts_at) + student_classes.with_deleted.includes(:student).where('created_at <= ? and deleted_at >= ?',
                                                                                                                      starts_at, starts_at)
    scs.map(&:student)
  end
end
