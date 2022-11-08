# frozen_string_literal: true

# == Schema Information
#
# Table name: student_classes
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#  klass_id   :uuid             not null
#  student_id :uuid             not null
#
# Indexes
#
#  index_student_classes_on_account_id  (account_id)
#  index_student_classes_on_klass_id    (klass_id)
#  index_student_classes_on_student_id  (student_id)
#  student_classes_id                   (account_id,student_id,klass_id,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (klass_id => klasses.id)
#  fk_rails_...  (student_id => students.id)
#
require 'test_helper'

class StudentClassTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
