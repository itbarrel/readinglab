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
  has_many :student_mettings, dependent: :destroy
  has_many :students, through: :student_mettings
  belongs_to :attendace_form, optional: true, class_name: 'Form'
  # belongs_to :attendance_form, class_name: 'Form', optional: true

  validates :starts_at, presence: true
  validates :ends_at, presence: true, date: { after_or_equal_to: :starts_at }

  before_validation :set_end_time

  def set_end_time
    self.ends_at = starts_at + klass.duration.minutes
  end

  def self.send_email_for(date)
    classes = all.where('date(starts_at) = ?', date).map(&:klass).uniq
    student_ids = StudentClass.where(klass_id: classes).map(&:student_id).uniq
    parents = Parent.joins(:children).where(students: { id: student_ids })
    parents.notify_all_about_klass
  end
end
