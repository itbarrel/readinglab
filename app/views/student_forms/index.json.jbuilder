# frozen_string_literal: true

json.array! @student_forms, partial: 'student_forms/student_form', as: :student_form
