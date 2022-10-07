# frozen_string_literal: true

require 'application_system_test_case'

class ReceiptTypesTest < ApplicationSystemTestCase
  setup do
    @receipt_type = receipt_types(:one)
  end

  test 'visiting the index' do
    visit receipt_types_url
    assert_selector 'h1', text: 'Receipt types'
  end

  test 'should create receipt type' do
    visit receipt_types_url
    click_on 'New receipt type'

    fill_in 'Account', with: @receipt_type.account_id
    check 'Active' if @receipt_type.active
    fill_in 'Deleted at', with: @receipt_type.deleted_at
    fill_in 'Name', with: @receipt_type.name
    click_on 'Create Receipt type'

    assert_text 'Receipt type was successfully created'
    click_on 'Back'
  end

  test 'should update Receipt type' do
    visit receipt_type_url(@receipt_type)
    click_on 'Edit this receipt type', match: :first

    fill_in 'Account', with: @receipt_type.account_id
    check 'Active' if @receipt_type.active
    fill_in 'Deleted at', with: @receipt_type.deleted_at
    fill_in 'Name', with: @receipt_type.name
    click_on 'Update Receipt type'

    assert_text 'Receipt type was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Receipt type' do
    visit receipt_type_url(@receipt_type)
    click_on 'Destroy this receipt type', match: :first

    assert_text 'Receipt type was successfully destroyed'
  end
end
