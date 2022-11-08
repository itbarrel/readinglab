# frozen_string_literal: true

require 'test_helper'

class FormDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @form_detail = form_details(:one)
  end

  test 'should get index' do
    get form_details_url
    assert_response :success
  end

  test 'should get new' do
    get new_form_detail_url
    assert_response :success
  end

  test 'should create form_detail' do
    assert_difference('FormDetail.count') do
      post form_details_url,
           params: { form_detail: { account_id: @form_detail.account_id, active: @form_detail.active,
                                    deleted_at: @form_detail.deleted_at, form_id: @form_detail.form_id, form_values: @form_detail.form_values, parent_id: @form_detail.parent_id, parent_types: @form_detail.parent_types, user_id: @form_detail.user_id } }
    end

    assert_redirected_to form_detail_url(FormDetail.last)
  end

  test 'should show form_detail' do
    get form_detail_url(@form_detail)
    assert_response :success
  end

  test 'should get edit' do
    get edit_form_detail_url(@form_detail)
    assert_response :success
  end

  test 'should update form_detail' do
    patch form_detail_url(@form_detail),
          params: { form_detail: { account_id: @form_detail.account_id, active: @form_detail.active,
                                   deleted_at: @form_detail.deleted_at, form_id: @form_detail.form_id, form_values: @form_detail.form_values, parent_id: @form_detail.parent_id, parent_types: @form_detail.parent_types, user_id: @form_detail.user_id } }
    assert_redirected_to form_detail_url(@form_detail)
  end

  test 'should destroy form_detail' do
    assert_difference('FormDetail.count', -1) do
      delete form_detail_url(@form_detail)
    end

    assert_redirected_to form_details_url
  end
end
