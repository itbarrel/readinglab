# frozen_string_literal: true

require 'application_system_test_case'

class StudentFormsTest < ApplicationSystemTestCase
  setup do
    @student_form = student_forms(:one)
  end

  test 'visiting the index' do
    visit student_forms_url
    assert_selector 'h1', text: 'Student forms'
  end

  test 'should create student form' do
    visit student_forms_url
    click_on 'New student form'

    fill_in 'Deleted at', with: @student_form.deleted_at
    fill_in 'Klass form', with: @student_form.klass_form_id
    fill_in 'Student class', with: @student_form.student_class_id
    click_on 'Create Student form'

    assert_text 'Student form was successfully created'
    click_on 'Back'
  end

  test 'should update Student form' do
    visit student_form_url(@student_form)
    click_on 'Edit this student form', match: :first

    fill_in 'Deleted at', with: @student_form.deleted_at
    fill_in 'Klass form', with: @student_form.klass_form_id
    fill_in 'Student class', with: @student_form.student_class_id
    click_on 'Update Student form'

    assert_text 'Student form was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Student form' do
    visit student_form_url(@student_form)
    click_on 'Destroy this student form', match: :first

    assert_text 'Student form was successfully destroyed'
  end
end
