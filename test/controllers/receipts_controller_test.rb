# frozen_string_literal: true

require 'test_helper'

class ReceiptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @receipt = receipts(:one)
  end

  test 'should get index' do
    get receipts_url
    assert_response :success
  end

  test 'should get new' do
    get new_receipt_url
    assert_response :success
  end

  test 'should create receipt' do
    assert_difference('Receipt.count') do
      post receipts_url,
           params: { receipt: { acoount_id: @receipt.acoount_id, active: @receipt.active, amount: @receipt.amount,
                                datetime: @receipt.datetime, deleted_at: @receipt.deleted_at, detail: @receipt.detail, discount: @receipt.discount, discount_reason: @receipt.discount_reason, leave_count: @receipt.leave_count, receipt_type_id: @receipt.receipt_type_id, sessions_count: @receipt.sessions_count, user_id: @receipt.user_id } }
    end

    assert_redirected_to receipt_url(Receipt.last)
  end

  test 'should show receipt' do
    get receipt_url(@receipt)
    assert_response :success
  end

  test 'should get edit' do
    get edit_receipt_url(@receipt)
    assert_response :success
  end

  test 'should update receipt' do
    patch receipt_url(@receipt),
          params: { receipt: { acoount_id: @receipt.acoount_id, active: @receipt.active, amount: @receipt.amount,
                               datetime: @receipt.datetime, deleted_at: @receipt.deleted_at, detail: @receipt.detail, discount: @receipt.discount, discount_reason: @receipt.discount_reason, leave_count: @receipt.leave_count, receipt_type_id: @receipt.receipt_type_id, sessions_count: @receipt.sessions_count, user_id: @receipt.user_id } }
    assert_redirected_to receipt_url(@receipt)
  end

  test 'should destroy receipt' do
    assert_difference('Receipt.count', -1) do
      delete receipt_url(@receipt)
    end

    assert_redirected_to receipts_url
  end
end
