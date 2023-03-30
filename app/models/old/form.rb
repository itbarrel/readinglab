# frozen_string_literal: true

# == Schema Information
#
# Table name: forms
#
#  id              :uuid             not null, primary key
#  active          :boolean          default(TRUE)
#  attendance_form :boolean
#  current_lesson  :jsonb
#  deleted_at      :datetime
#  fields          :jsonb
#  for_assessment  :boolean
#  for_lesson      :boolean          default(FALSE)
#  lesson          :integer
#  name            :string(63)
#  previous_lesson :jsonb
#  created_at      :datetime
#  updated_at      :datetime
#  account_id      :uuid             not null
#
# Indexes
#
#  index_forms_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Old::Form < Old::ApplicationRecord
  belongs_to :account
  has_many :interviews, class_name: 'Old::Interview'
  has_many :class_template_forms, class_name: 'Old::ClassTemplateForm'
  has_many :form_details, class_name: 'Old::FormDetail'
  has_many :student_meetings, class_name: 'Old::StudentMeeting'
  has_many :class_templates, through: :class_template_forms, class_name: 'Old::ClassTemplate'
  scope :active, -> { where(active: true) }
  scope :attendance_forms, -> { where(attendance_form: true) }
  acts_as_paranoid
end
