# frozen_string_literal: true

# == Schema Information
#
# Table name: forms
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  fields     :jsonb
#  name       :string
#  purpose    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#
# Indexes
#
#  forms_name                 (account_id,name,deleted_at) UNIQUE
#  index_forms_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Old::Form < Old::ApplicationRecord
  belongs_to :account
  has_one :interview, class_name: 'Old::Interview'
  has_many :class_template_forms, class_name: 'Old::ClassTemplateForm'
  has_many :form_details, class_name: 'Old::FormDetail'
  has_many :student_meetings, class_name: 'Old::StudentMeeting'
  has_many :class_templates, through: :class_template_forms, class_name: 'Old::ClassTemplate'
  scope :active, -> { where(active: true) }
  scope :attendance_forms, -> { where(attendance_form: true) }
  acts_as_paranoid
end
