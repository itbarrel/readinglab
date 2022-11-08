# frozen_string_literal: true

require 'application_system_test_case'

class StudentsTest < ApplicationSystemTestCase
  setup do
    @student = students(:one)
  end

  test 'visiting the index' do
    visit students_url
    assert_selector 'h1', text: 'Students'
  end

  test 'should create student' do
    visit students_url
    click_on 'New student'

    fill_in 'Account', with: @student.account_id
    check 'Active' if @student.active
    fill_in 'Credit session', with: @student.credit_session
    fill_in 'Dates', with: @student.dates
    fill_in 'Datetime', with: @student.datetime
    fill_in 'Deleted at', with: @student.deleted_at
    fill_in 'Dob', with: @student.dob
    fill_in 'First', with: @student.first
    fill_in 'Grade', with: @student.grade
    fill_in 'Last', with: @student.last
    fill_in 'Prepaid sessions', with: @student.prepaid_sessions
    fill_in 'Programs', with: @student.programs
    fill_in 'Registration date', with: @student.registration_date
    fill_in 'School', with: @student.school
    fill_in 'Settings', with: @student.settings
    fill_in 'Sex', with: @student.sex
    fill_in 'Status', with: @student.status
    fill_in 'String', with: @student.string
    click_on 'Create Student'

    assert_text 'Student was successfully created'
    click_on 'Back'
  end

  test 'should update Student' do
    visit student_url(@student)
    click_on 'Edit this student', match: :first

    fill_in 'Account', with: @student.account_id
    check 'Active' if @student.active
    fill_in 'Credit session', with: @student.credit_session
    fill_in 'Dates', with: @student.dates
    fill_in 'Datetime', with: @student.datetime
    fill_in 'Deleted at', with: @student.deleted_at
    fill_in 'Dob', with: @student.dob
    fill_in 'First', with: @student.first
    fill_in 'Grade', with: @student.grade
    fill_in 'Last', with: @student.last
    fill_in 'Prepaid sessions', with: @student.prepaid_sessions
    fill_in 'Programs', with: @student.programs
    fill_in 'Registration date', with: @student.registration_date
    fill_in 'School', with: @student.school
    fill_in 'Settings', with: @student.settings
    fill_in 'Sex', with: @student.sex
    fill_in 'Status', with: @student.status
    fill_in 'String', with: @student.string
    click_on 'Update Student'

    assert_text 'Student was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Student' do
    visit student_url(@student)
    click_on 'Destroy this student', match: :first

    assert_text 'Student was successfully destroyed'
  end
end
