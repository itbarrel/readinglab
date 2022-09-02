require "application_system_test_case"

class AccountTypesTest < ApplicationSystemTestCase
  setup do
    @account_type = account_types(:one)
  end

  test "visiting the index" do
    visit account_types_url
    assert_selector "h1", text: "Account types"
  end

  test "should create account type" do
    visit account_types_url
    click_on "New account type"

    fill_in "Name", with: @account_type.name
    click_on "Create Account type"

    assert_text "Account type was successfully created"
    click_on "Back"
  end

  test "should update Account type" do
    visit account_type_url(@account_type)
    click_on "Edit this account type", match: :first

    fill_in "Name", with: @account_type.name
    click_on "Update Account type"

    assert_text "Account type was successfully updated"
    click_on "Back"
  end

  test "should destroy Account type" do
    visit account_type_url(@account_type)
    click_on "Destroy this account type", match: :first

    assert_text "Account type was successfully destroyed"
  end
end
