# frozen_string_literal: true

require 'test_helper'

class ReceiptTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @receipt_type = receipt_types(:one)
  end

  test 'should get index' do
    get receipt_types_url
    assert_response :success
  end

  test 'should get new' do
    get new_receipt_type_url
    assert_response :success
  end

  test 'should create receipt_type' do
    assert_difference('ReceiptType.count') do
      post receipt_types_url,
           params: { receipt_type: { account_id: @receipt_type.account_id, active: @receipt_type.active,
                                     deleted_at: @receipt_type.deleted_at, name: @receipt_type.name } }
    end

    assert_redirected_to receipt_type_url(ReceiptType.last)
  end

  test 'should show receipt_type' do
    get receipt_type_url(@receipt_type)
    assert_response :success
  end

  test 'should get edit' do
    get edit_receipt_type_url(@receipt_type)
    assert_response :success
  end

  test 'should update receipt_type' do
    patch receipt_type_url(@receipt_type),
          params: { receipt_type: { account_id: @receipt_type.account_id, active: @receipt_type.active,
                                    deleted_at: @receipt_type.deleted_at, name: @receipt_type.name } }
    assert_redirected_to receipt_type_url(@receipt_type)
  end

  test 'should destroy receipt_type' do
    assert_difference('ReceiptType.count', -1) do
      delete receipt_type_url(@receipt_type)
    end

    assert_redirected_to receipt_types_url
  end
end
