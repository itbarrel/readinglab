# frozen_string_literal: true

require 'application_system_test_case'

class StudentMeetingsTest < ApplicationSystemTestCase
  setup do
    @student_meeting = student_meetings(:one)
  end

  test 'visiting the index' do
    visit student_meetings_url
    assert_selector 'h1', text: 'student  meetings'
  end

  test 'should create student  meeting' do
    visit student_meetings_url
    click_on 'New student  meeting'

    click_on 'Create student  meeting'

    assert_text 'student  meeting was successfully created'
    click_on 'Back'
  end

  test 'should update student  meeting' do
    visit student_meeting_url(@student_meeting)
    click_on 'Edit this student  meeting', match: :first

    click_on 'Update student  meeting'

    assert_text 'student  meeting was successfully updated'
    click_on 'Back'
  end

  test 'should destroy student  meeting' do
    visit student_meeting_url(@student_meeting)
    click_on 'Destroy this student  meeting', match: :first

    assert_text 'student  meeting was successfully destroyed'
  end
end
