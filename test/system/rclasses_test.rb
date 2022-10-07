# frozen_string_literal: true

require 'application_system_test_case'

class RclassesTest < ApplicationSystemTestCase
  setup do
    @rclass = rclasses(:one)
  end

  test 'visiting the index' do
    visit rclasses_url
    assert_selector 'h1', text: 'Rclasses'
  end

  test 'should create rclass' do
    visit rclasses_url
    click_on 'New rclass'

    fill_in 'Account', with: @rclass.account_id
    check 'Active' if @rclass.active
    fill_in 'Deleted at', with: @rclass.deleted_at
    fill_in 'Description', with: @rclass.description
    fill_in 'Duration', with: @rclass.duration
    fill_in 'Est end date', with: @rclass.est_end_date
    check 'Friday' if @rclass.friday
    fill_in 'Max students', with: @rclass.max_students
    fill_in 'Min students', with: @rclass.min_students
    check 'Monday' if @rclass.monday
    fill_in 'Name', with: @rclass.name
    fill_in 'Room', with: @rclass.room_id
    check 'Saturday' if @rclass.saturday
    fill_in 'Session range', with: @rclass.session_range
    fill_in 'Start', with: @rclass.start
    check 'Sunday' if @rclass.sunday
    check 'Thursday' if @rclass.thursday
    check 'Tuesday' if @rclass.tuesday
    fill_in 'User', with: @rclass.user_id
    check 'Wednesday' if @rclass.wednesday
    click_on 'Create Rclass'

    assert_text 'Rclass was successfully created'
    click_on 'Back'
  end

  test 'should update Rclass' do
    visit rclass_url(@rclass)
    click_on 'Edit this rclass', match: :first

    fill_in 'Account', with: @rclass.account_id
    check 'Active' if @rclass.active
    fill_in 'Deleted at', with: @rclass.deleted_at
    fill_in 'Description', with: @rclass.description
    fill_in 'Duration', with: @rclass.duration
    fill_in 'Est end date', with: @rclass.est_end_date
    check 'Friday' if @rclass.friday
    fill_in 'Max students', with: @rclass.max_students
    fill_in 'Min students', with: @rclass.min_students
    check 'Monday' if @rclass.monday
    fill_in 'Name', with: @rclass.name
    fill_in 'Room', with: @rclass.room_id
    check 'Saturday' if @rclass.saturday
    fill_in 'Session range', with: @rclass.session_range
    fill_in 'Start', with: @rclass.start
    check 'Sunday' if @rclass.sunday
    check 'Thursday' if @rclass.thursday
    check 'Tuesday' if @rclass.tuesday
    fill_in 'User', with: @rclass.user_id
    check 'Wednesday' if @rclass.wednesday
    click_on 'Update Rclass'

    assert_text 'Rclass was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Rclass' do
    visit rclass_url(@rclass)
    click_on 'Destroy this rclass', match: :first

    assert_text 'Rclass was successfully destroyed'
  end
end
