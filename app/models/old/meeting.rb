# frozen_string_literal: true

# == Schema Information
#
# Table name: meetings
#
#  id           :uuid             not null, primary key
#  active       :boolean          default(TRUE)
#  cancel       :boolean          default(FALSE), not null
#  deleted_at   :datetime
#  form_values  :jsonb
#  resecheduled :uuid
#  start        :datetime         not null
#  created_at   :datetime
#  updated_at   :datetime
#  account_id   :uuid             not null
#  form_id      :uuid
#  r_class_id   :uuid             not null
#
# Indexes
#
#  index_meetings_on_account_id  (account_id)
#  index_meetings_on_form_id     (form_id)
#  index_meetings_on_r_class_id  (r_class_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (form_id => forms.id)
#  fk_rails_...  (r_class_id => r_classes.id) ON DELETE => nullify
#
class Old::Meeting < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :r_class, class_name: 'Old::RClass'
  has_many :paid_student_sessions, dependent: :destroy, class_name: 'Old::PaidStudentSession'
  # belongs_to :teacher, class_name: "User",foreign_key: "teacher_id"
  belongs_to :form, class_name: 'Old::Form'
  has_many :form_details, as: :parent, class_name: 'Old::FormDetail'
  acts_as_paranoid
  scope :active, -> { where(active: true) }
  has_many :student_meetings, dependent: :destroy, class_name: 'Old::StudentMeeting'
end
