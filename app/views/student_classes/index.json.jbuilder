# frozen_string_literal: true

json.array! @student_classes, partial: 'student_classes/student_class', as: :student_class
