# frozen_string_literal: true

require 'application_system_test_case'

class RoomsTest < ApplicationSystemTestCase
  setup do
    @room = rooms(:one)
  end

  test 'visiting the index' do
    visit rooms_url
    assert_selector 'h1', text: 'Rooms'
  end

  test 'should create room' do
    visit rooms_url
    click_on 'New room'

    fill_in 'Account', with: @room.account_id
    fill_in 'Active', with: @room.active
    fill_in 'Boolean', with: @room.boolean
    fill_in 'Capacity', with: @room.capacity
    fill_in 'Color', with: @room.color
    fill_in 'Deleted at', with: @room.deleted_at
    fill_in 'Integer', with: @room.integer
    fill_in 'Name', with: @room.name
    fill_in 'References', with: @room.references
    fill_in 'String', with: @room.string
    click_on 'Create Room'

    assert_text 'Room was successfully created'
    click_on 'Back'
  end

  test 'should update Room' do
    visit room_url(@room)
    click_on 'Edit this room', match: :first

    fill_in 'Account', with: @room.account_id
    fill_in 'Active', with: @room.active
    fill_in 'Boolean', with: @room.boolean
    fill_in 'Capacity', with: @room.capacity
    fill_in 'Color', with: @room.color
    fill_in 'Deleted at', with: @room.deleted_at
    fill_in 'Integer', with: @room.integer
    fill_in 'Name', with: @room.name
    fill_in 'References', with: @room.references
    fill_in 'String', with: @room.string
    click_on 'Update Room'

    assert_text 'Room was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Room' do
    visit room_url(@room)
    click_on 'Destroy this room', match: :first

    assert_text 'Room was successfully destroyed'
  end
end
