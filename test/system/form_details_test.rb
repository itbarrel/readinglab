require "application_system_test_case"

class FormDetailsTest < ApplicationSystemTestCase
  setup do
    @form_detail = form_details(:one)
  end

  test "visiting the index" do
    visit form_details_url
    assert_selector "h1", text: "Form details"
  end

  test "should create form detail" do
    visit form_details_url
    click_on "New form detail"

    fill_in "Account", with: @form_detail.account_id
    check "Active" if @form_detail.active
    fill_in "Deleted at", with: @form_detail.deleted_at
    fill_in "Form", with: @form_detail.form_id
    fill_in "Form values", with: @form_detail.form_values
    fill_in "Parent", with: @form_detail.parent_id
    fill_in "Parent types", with: @form_detail.parent_types
    fill_in "User", with: @form_detail.user_id
    click_on "Create Form detail"

    assert_text "Form detail was successfully created"
    click_on "Back"
  end

  test "should update Form detail" do
    visit form_detail_url(@form_detail)
    click_on "Edit this form detail", match: :first

    fill_in "Account", with: @form_detail.account_id
    check "Active" if @form_detail.active
    fill_in "Deleted at", with: @form_detail.deleted_at
    fill_in "Form", with: @form_detail.form_id
    fill_in "Form values", with: @form_detail.form_values
    fill_in "Parent", with: @form_detail.parent_id
    fill_in "Parent types", with: @form_detail.parent_types
    fill_in "User", with: @form_detail.user_id
    click_on "Update Form detail"

    assert_text "Form detail was successfully updated"
    click_on "Back"
  end

  test "should destroy Form detail" do
    visit form_detail_url(@form_detail)
    click_on "Destroy this form detail", match: :first

    assert_text "Form detail was successfully destroyed"
  end
end
