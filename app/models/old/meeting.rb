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
