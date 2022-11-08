# frozen_string_literal: true

require 'test_helper'

class StudentFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student_form = student_forms(:one)
  end

  test 'should get index' do
    get student_forms_url
    assert_response :success
  end

  test 'should get new' do
    get new_student_form_url
    assert_response :success
  end

  test 'should create student_form' do
    assert_difference('StudentForm.count') do
      post student_forms_url,
           params: { student_form: { deleted_at: @student_form.deleted_at, klass_form_id: @student_form.klass_form_id,
                                     student_class_id: @student_form.student_class_id } }
    end

    assert_redirected_to student_form_url(StudentForm.last)
  end

  test 'should show student_form' do
    get student_form_url(@student_form)
    assert_response :success
  end

  test 'should get edit' do
    get edit_student_form_url(@student_form)
    assert_response :success
  end

  test 'should update student_form' do
    patch student_form_url(@student_form),
          params: { student_form: { deleted_at: @student_form.deleted_at, klass_form_id: @student_form.klass_form_id,
                                    student_class_id: @student_form.student_class_id } }
    assert_redirected_to student_form_url(@student_form)
  end

  test 'should destroy student_form' do
    assert_difference('StudentForm.count', -1) do
      delete student_form_url(@student_form)
    end

    assert_redirected_to student_forms_url
  end
end
