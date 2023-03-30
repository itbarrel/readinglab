# frozen_string_literal: true

# == Schema Information
#
# Table name: interviews
#
#  id         :uuid             not null, primary key
#  active     :boolean          default(TRUE)
#  date       :datetime
#  deleted_at :datetime
#  feedback   :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid
#  form_id    :uuid
#  student_id :uuid
#
# Indexes
#
#  index_interviews_on_account_id  (account_id)
#  index_interviews_on_form_id     (form_id)
#  index_interviews_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (form_id => forms.id)
#
class Old::Interview < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :student, class_name: 'Old::Student'
  belongs_to :form, class_name: 'Old::Form'
  has_many :form_details, as: :parent, class_name: 'Old::FormDetail'
  has_one :interview_result, class_name: 'Old::InterviewResult '
  after_update :convert_timezone
  scope :active, -> { where(active: true) }

  acts_as_paranoid
end
