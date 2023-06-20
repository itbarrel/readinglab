# frozen_string_literal: true

# == Schema Information
#
# Table name: student_classes
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  klass_id   :uuid             not null
#  student_id :uuid             not null
#
# Indexes
#
#  index_student_classes_on_klass_id    (klass_id)
#  index_student_classes_on_student_id  (student_id)
#  student_classes_id                   (student_id,klass_id,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (klass_id => klasses.id)
#  fk_rails_...  (student_id => students.id)
#
class StudentClass < ApplicationRecord
  belongs_to :student
  belongs_to :klass

  has_many :student_forms, dependent: :destroy

  validates :student_id, uniqueness: { scope: %i[klass_id deleted_at] }

  after_create :mark_student_active
  after_destroy :mark_student_waitlisted
  before_validation :validate_max_students, on: :create

  def mark_student_active
    student.active!
  end

  def mark_student_waitlisted
    student.wait_listed!
  end

  private

  def validate_max_students
    return true unless klass.students.length >= klass.max_students

    errors.add(:base, 'Max Student Limit Reached.')
    false
  end
end
