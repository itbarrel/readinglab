# frozen_string_literal: true

require 'test_helper'

class ParentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parent = parents(:one)
  end

  test 'should get index' do
    get parents_url
    assert_response :success
  end

  test 'should get new' do
    get new_parent_url
    assert_response :success
  end

  test 'should create parent' do
    assert_difference('Parent.count') do
      post parents_url,
           params: { parent: { account_id: @parent.account_id, active: @parent.active, address: @parent.address,
                               city_id: @parent.city_id, deleted_at: @parent.deleted_at, father_email: @parent.father_email, father_first: @parent.father_first, father_last: @parent.father_last, father_phone: @parent.father_phone, mother_email: @parent.mother_email, mother_first: @parent.mother_first, mother_last: @parent.mother_last, mother_phone: @parent.mother_phone, postal_code: @parent.postal_code, state: @parent.state } }
    end

    assert_redirected_to parent_url(Parent.last)
  end

  test 'should show parent' do
    get parent_url(@parent)
    assert_response :success
  end

  test 'should get edit' do
    get edit_parent_url(@parent)
    assert_response :success
  end

  test 'should update parent' do
    patch parent_url(@parent),
          params: { parent: { account_id: @parent.account_id, active: @parent.active, address: @parent.address,
                              city_id: @parent.city_id, deleted_at: @parent.deleted_at, father_email: @parent.father_email, father_first: @parent.father_first, father_last: @parent.father_last, father_phone: @parent.father_phone, mother_email: @parent.mother_email, mother_first: @parent.mother_first, mother_last: @parent.mother_last, mother_phone: @parent.mother_phone, postal_code: @parent.postal_code, state: @parent.state } }
    assert_redirected_to parent_url(@parent)
  end

  test 'should destroy parent' do
    assert_difference('Parent.count', -1) do
      delete parent_url(@parent)
    end

    assert_redirected_to parents_url
  end
end
