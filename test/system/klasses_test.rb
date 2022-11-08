# frozen_string_literal: true

require 'application_system_test_case'

class KlassesTest < ApplicationSystemTestCase
  setup do
    @klass = klasses(:one)
  end

  test 'visiting the index' do
    visit klasses_url
    assert_selector 'h1', text: 'Klasses'
  end

  test 'should create klass' do
    visit klasses_url
    click_on 'New klass'

    fill_in 'Account', with: @klass.account_id
    check 'Active' if @klass.active
    fill_in 'Deleted at', with: @klass.deleted_at
    fill_in 'Description', with: @klass.description
    fill_in 'Duration', with: @klass.duration
    fill_in 'Est end date', with: @klass.est_end_date
    check 'Friday' if @klass.friday
    fill_in 'Max students', with: @klass.max_students
    fill_in 'Min students', with: @klass.min_students
    check 'Monday' if @klass.monday
    fill_in 'Name', with: @klass.name
    fill_in 'Room', with: @klass.room_id
    check 'Saturday' if @klass.saturday
    fill_in 'Session range', with: @klass.session_range
    fill_in 'Start', with: @klass.start
    check 'Sunday' if @klass.sunday
    fill_in 'Teacher', with: @klass.teacher_id
    check 'Thursday' if @klass.thursday
    check 'Tuesday' if @klass.tuesday
    check 'Wednesday' if @klass.wednesday
    click_on 'Create Klass'

    assert_text 'Klass was successfully created'
    click_on 'Back'
  end

  test 'should update Klass' do
    visit klass_url(@klass)
    click_on 'Edit this klass', match: :first

    fill_in 'Account', with: @klass.account_id
    check 'Active' if @klass.active
    fill_in 'Deleted at', with: @klass.deleted_at
    fill_in 'Description', with: @klass.description
    fill_in 'Duration', with: @klass.duration
    fill_in 'Est end date', with: @klass.est_end_date
    check 'Friday' if @klass.friday
    fill_in 'Max students', with: @klass.max_students
    fill_in 'Min students', with: @klass.min_students
    check 'Monday' if @klass.monday
    fill_in 'Name', with: @klass.name
    fill_in 'Room', with: @klass.room_id
    check 'Saturday' if @klass.saturday
    fill_in 'Session range', with: @klass.session_range
    fill_in 'Start', with: @klass.start
    check 'Sunday' if @klass.sunday
    fill_in 'Teacher', with: @klass.teacher_id
    check 'Thursday' if @klass.thursday
    check 'Tuesday' if @klass.tuesday
    check 'Wednesday' if @klass.wednesday
    click_on 'Update Klass'

    assert_text 'Klass was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Klass' do
    visit klass_url(@klass)
    click_on 'Destroy this klass', match: :first

    assert_text 'Klass was successfully destroyed'
  end
end
