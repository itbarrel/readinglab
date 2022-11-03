# frozen_string_literal: true

# == Schema Information
#
# Table name: student_forms
#
#  id               :uuid             not null, primary key
#  deleted_at       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  klass_form_id    :uuid             not null
#  student_class_id :uuid             not null
#
# Indexes
#
#  index_student_forms_on_klass_form_id     (klass_form_id)
#  index_student_forms_on_student_class_id  (student_class_id)
#  student_forms_id                         (student_class_id,klass_form_id,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (klass_form_id => klass_forms.id)
#  fk_rails_...  (student_class_id => student_classes.id)
#
class StudentForm < ApplicationRecord
  belongs_to :student_class
  belongs_to :klass_form
end
