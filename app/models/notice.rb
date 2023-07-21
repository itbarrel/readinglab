# frozen_string_literal: true

# == Schema Information
#
# Table name: notices
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  email_text :text
#  reason     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :uuid             not null
#  student_id :uuid             not null
#
# Indexes
#
#  index_notices_on_parent_id   (parent_id)
#  index_notices_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => parents.id)
#  fk_rails_...  (student_id => students.id)
#
class Notice < ApplicationRecord
  belongs_to :parent
  belongs_to :student
end
