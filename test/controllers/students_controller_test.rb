# frozen_string_literal: true

require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = students(:one)
  end

  test 'should get index' do
    get students_url
    assert_response :success
  end

  test 'should get new' do
    get new_student_url
    assert_response :success
  end

  test 'should create student' do
    assert_difference('Student.count') do
      post students_url,
           params: { student: { account_id: @student.account_id, active: @student.active, credit_session: @student.credit_session,
                                dates: @student.dates, datetime: @student.datetime, deleted_at: @student.deleted_at, dob: @student.dob, first: @student.first, grade: @student.grade, last: @student.last, prepaid_sessions: @student.prepaid_sessions, programs: @student.programs, registration_date: @student.registration_date, school: @student.school, settings: @student.settings, sex: @student.sex, status: @student.status, string: @student.string } }
    end

    assert_redirected_to student_url(Student.last)
  end

  test 'should show student' do
    get student_url(@student)
    assert_response :success
  end

  test 'should get edit' do
    get edit_student_url(@student)
    assert_response :success
  end

  test 'should update student' do
    patch student_url(@student),
          params: { student: { account_id: @student.account_id, active: @student.active, credit_session: @student.credit_session,
                               dates: @student.dates, datetime: @student.datetime, deleted_at: @student.deleted_at, dob: @student.dob, first: @student.first, grade: @student.grade, last: @student.last, prepaid_sessions: @student.prepaid_sessions, programs: @student.programs, registration_date: @student.registration_date, school: @student.school, settings: @student.settings, sex: @student.sex, status: @student.status, string: @student.string } }
    assert_redirected_to student_url(@student)
  end

  test 'should destroy student' do
    assert_difference('Student.count', -1) do
      delete student_url(@student)
    end

    assert_redirected_to students_url
  end
end
