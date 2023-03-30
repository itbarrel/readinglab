# frozen_string_literal: true

# == Schema Information
#
# Table name: interview_results
#
#  id           :uuid             not null, primary key
#  active       :boolean          default(TRUE)
#  deleted_at   :datetime
#  form_values  :jsonb
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :uuid
#  form_id      :uuid
#  interview_id :uuid
#  student_id   :uuid
#
# Indexes
#
#  index_interview_results_on_account_id    (account_id)
#  index_interview_results_on_form_id       (form_id)
#  index_interview_results_on_interview_id  (interview_id)
#  index_interview_results_on_student_id    (student_id)
#
class Old::InterviewResult < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :student, class_name: 'Old::Student'
  belongs_to :interview, class_name: 'Old::Interview'
  belongs_to :form, class_name: 'Old::Form'
  scope :active, -> { where(active: true) }
  acts_as_paranoid
end
