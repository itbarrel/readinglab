# frozen_string_literal: true

# == Schema Information
#
# Table name: assessments
#
#  id          :uuid             not null, primary key
#  active      :boolean          default(TRUE)
#  completed   :boolean          default(FALSE), not null
#  deleted_at  :datetime
#  form_values :jsonb
#  start       :datetime         not null
#  created_at  :datetime
#  updated_at  :datetime
#  account_id  :uuid             not null
#  assessor_id :uuid             not null
#  form_id     :uuid
#  room_id     :uuid             not null
#  student_id  :uuid             not null
#
# Indexes
#
#  index_assessments_on_account_id   (account_id)
#  index_assessments_on_assessor_id  (assessor_id)
#  index_assessments_on_form_id      (form_id)
#  index_assessments_on_room_id      (room_id)
#  index_assessments_on_student_id   (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (assessor_id => users.id)
#  fk_rails_...  (form_id => forms.id)
#  fk_rails_...  (room_id => rooms.id)
#  fk_rails_...  (student_id => students.id)
#
class Old::Assessment < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :room, class_name: 'Old::Room'
  belongs_to :assessor, class_name: 'User'
  belongs_to :student, class_name: 'Old::Student'
  belongs_to :form, class_name: 'Old::Form'
  acts_as_paranoid
  scope :active, -> { where(active: true) }

  def title
    assessor.name
  end

  def name
    "#{student.name} in room #{room.name} with #{assessor.name}"
  end
end
