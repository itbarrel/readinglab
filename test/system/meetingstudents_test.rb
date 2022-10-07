# frozen_string_literal: true

require 'application_system_test_case'

class MeetingstudentsTest < ApplicationSystemTestCase
  setup do
    @meetingstudent = meetingstudents(:one)
  end

  test 'visiting the index' do
    visit meetingstudents_url
    assert_selector 'h1', text: 'Meetingstudents'
  end

  test 'should create meetingstudent' do
    visit meetingstudents_url
    click_on 'New meetingstudent'

    fill_in 'Account', with: @meetingstudent.account_id
    check 'Active' if @meetingstudent.active
    fill_in 'Attended', with: @meetingstudent.attended
    fill_in 'Deleted at', with: @meetingstudent.deleted_at
    fill_in 'Meeting', with: @meetingstudent.meeting_id
    fill_in 'User', with: @meetingstudent.user_id
    click_on 'Create Meetingstudent'

    assert_text 'Meetingstudent was successfully created'
    click_on 'Back'
  end

  test 'should update Meetingstudent' do
    visit meetingstudent_url(@meetingstudent)
    click_on 'Edit this meetingstudent', match: :first

    fill_in 'Account', with: @meetingstudent.account_id
    check 'Active' if @meetingstudent.active
    fill_in 'Attended', with: @meetingstudent.attended
    fill_in 'Deleted at', with: @meetingstudent.deleted_at
    fill_in 'Meeting', with: @meetingstudent.meeting_id
    fill_in 'User', with: @meetingstudent.user_id
    click_on 'Update Meetingstudent'

    assert_text 'Meetingstudent was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Meetingstudent' do
    visit meetingstudent_url(@meetingstudent)
    click_on 'Destroy this meetingstudent', match: :first

    assert_text 'Meetingstudent was successfully destroyed'
  end
end
