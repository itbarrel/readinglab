# frozen_string_literal: true

require 'application_system_test_case'

class ParentsTest < ApplicationSystemTestCase
  setup do
    @parent = parents(:one)
  end

  test 'visiting the index' do
    visit parents_url
    assert_selector 'h1', text: 'Parents'
  end

  test 'should create parent' do
    visit parents_url
    click_on 'New parent'

    fill_in 'Account', with: @parent.account_id
    check 'Active' if @parent.active
    fill_in 'Address', with: @parent.address
    fill_in 'City', with: @parent.city_id
    fill_in 'Deleted at', with: @parent.deleted_at
    fill_in 'Father email', with: @parent.father_email
    fill_in 'Father first', with: @parent.father_first
    fill_in 'Father last', with: @parent.father_last
    fill_in 'Father phone', with: @parent.father_phone
    fill_in 'Mother email', with: @parent.mother_email
    fill_in 'Mother first', with: @parent.mother_first
    fill_in 'Mother last', with: @parent.mother_last
    fill_in 'Mother phone', with: @parent.mother_phone
    fill_in 'Postal code', with: @parent.postal_code
    fill_in 'State', with: @parent.state
    click_on 'Create Parent'

    assert_text 'Parent was successfully created'
    click_on 'Back'
  end

  test 'should update Parent' do
    visit parent_url(@parent)
    click_on 'Edit this parent', match: :first

    fill_in 'Account', with: @parent.account_id
    check 'Active' if @parent.active
    fill_in 'Address', with: @parent.address
    fill_in 'City', with: @parent.city_id
    fill_in 'Deleted at', with: @parent.deleted_at
    fill_in 'Father email', with: @parent.father_email
    fill_in 'Father first', with: @parent.father_first
    fill_in 'Father last', with: @parent.father_last
    fill_in 'Father phone', with: @parent.father_phone
    fill_in 'Mother email', with: @parent.mother_email
    fill_in 'Mother first', with: @parent.mother_first
    fill_in 'Mother last', with: @parent.mother_last
    fill_in 'Mother phone', with: @parent.mother_phone
    fill_in 'Postal code', with: @parent.postal_code
    fill_in 'State', with: @parent.state
    click_on 'Update Parent'

    assert_text 'Parent was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Parent' do
    visit parent_url(@parent)
    click_on 'Destroy this parent', match: :first

    assert_text 'Parent was successfully destroyed'
  end
end
