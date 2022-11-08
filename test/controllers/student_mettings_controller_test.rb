# frozen_string_literal: true

require 'test_helper'

class StudentMeetingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student_meetings = student_meetings(:one)
  end

  test 'should get index' do
    get student_meetings_url
    assert_response :success
  end

  test 'should get new' do
    get new_student_meetings_url
    assert_response :success
  end

  test 'should create student_meetings' do
    assert_difference('StudentMeeting.count') do
      post student_meetings_url, params: { student_meetings: {} }
    end

    assert_redirected_to student_meetings_url(StudentMeeting.last)
  end

  test 'should show student_meetings' do
    get student_meetings_url(@student_meeting)
    assert_response :success
  end

  test 'should get edit' do
    get edit_student_meetings_url(@student_meeting)
    assert_response :success
  end

  test 'should update student_meetings' do
    patch student_meetings_url(@student_meeting), params: { student_meetings: {} }
    assert_redirected_to student_meetings_url(@student_meeting)
  end

  test 'should destroy student_meetings' do
    assert_difference('StudentMeeting.count', -1) do
      delete student_meetings_url(@student_meeting)
    end

    assert_redirected_to student_meetings_url
  end
end
