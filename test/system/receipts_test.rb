# frozen_string_literal: true

require 'application_system_test_case'

class ReceiptsTest < ApplicationSystemTestCase
  setup do
    @receipt = receipts(:one)
  end

  test 'visiting the index' do
    visit receipts_url
    assert_selector 'h1', text: 'Receipts'
  end

  test 'should create receipt' do
    visit receipts_url
    click_on 'New receipt'

    fill_in 'Acoount', with: @receipt.acoount_id
    check 'Active' if @receipt.active
    fill_in 'Amount', with: @receipt.amount
    fill_in 'Datetime', with: @receipt.datetime
    fill_in 'Deleted at', with: @receipt.deleted_at
    fill_in 'Detail', with: @receipt.detail
    fill_in 'Discount', with: @receipt.discount
    fill_in 'Discount reason', with: @receipt.discount_reason
    fill_in 'Leave count', with: @receipt.leave_count
    fill_in 'Receipt type', with: @receipt.receipt_type_id
    fill_in 'Sessions count', with: @receipt.sessions_count
    fill_in 'User', with: @receipt.user_id
    click_on 'Create Receipt'

    assert_text 'Receipt was successfully created'
    click_on 'Back'
  end

  test 'should update Receipt' do
    visit receipt_url(@receipt)
    click_on 'Edit this receipt', match: :first

    fill_in 'Acoount', with: @receipt.acoount_id
    check 'Active' if @receipt.active
    fill_in 'Amount', with: @receipt.amount
    fill_in 'Datetime', with: @receipt.datetime
    fill_in 'Deleted at', with: @receipt.deleted_at
    fill_in 'Detail', with: @receipt.detail
    fill_in 'Discount', with: @receipt.discount
    fill_in 'Discount reason', with: @receipt.discount_reason
    fill_in 'Leave count', with: @receipt.leave_count
    fill_in 'Receipt type', with: @receipt.receipt_type_id
    fill_in 'Sessions count', with: @receipt.sessions_count
    fill_in 'User', with: @receipt.user_id
    click_on 'Update Receipt'

    assert_text 'Receipt was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Receipt' do
    visit receipt_url(@receipt)
    click_on 'Destroy this receipt', match: :first

    assert_text 'Receipt was successfully destroyed'
  end
end
