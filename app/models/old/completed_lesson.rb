# frozen_string_literal: true

# == Schema Information
#
# Table name: completed_lessons
#
#  id         :uuid             not null, primary key
#  active     :boolean          default(TRUE)
#  deleted_at :datetime
#  lesson     :integer
#  start      :date
#  created_at :datetime
#  updated_at :datetime
#  account_id :uuid             not null
#  student_id :uuid             not null
#
# Indexes
#
#  index_completed_lessons_on_account_id  (account_id)
#  index_completed_lessons_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Old::CompletedLesson < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :student, class_name: 'Old::Student'
  acts_as_paranoid
  scope :active, -> { where(active: true) }
end
