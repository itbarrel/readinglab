require "application_system_test_case"

class AccountsTest < ApplicationSystemTestCase
  setup do
    @account = accounts(:one)
  end

  test "visiting the index" do
    visit accounts_url
    assert_selector "h1", text: "Accounts"
  end

  test "should create account" do
    visit accounts_url
    click_on "New account"

    fill_in "Account types", with: @account.account_types_id
    check "Active" if @account.active
    fill_in "Address", with: @account.address
    fill_in "Billing scheme", with: @account.billing_scheme
    fill_in "Country code", with: @account.country_code
    fill_in "Currency", with: @account.currency
    fill_in "Deleted at", with: @account.deleted_at
    fill_in "Email", with: @account.email
    fill_in "Mobile", with: @account.mobile
    fill_in "Name", with: @account.name
    check "Notify emails" if @account.notify_emails
    fill_in "Parent", with: @account.parent_id
    fill_in "Postal code", with: @account.postal_code
    fill_in "Province", with: @account.province
    fill_in "Settings", with: @account.settings
    fill_in "String", with: @account.string
    fill_in "Timezone", with: @account.timezone
    click_on "Create Account"

    assert_text "Account was successfully created"
    click_on "Back"
  end

  test "should update Account" do
    visit account_url(@account)
    click_on "Edit this account", match: :first

    fill_in "Account types", with: @account.account_types_id
    check "Active" if @account.active
    fill_in "Address", with: @account.address
    fill_in "Billing scheme", with: @account.billing_scheme
    fill_in "Country code", with: @account.country_code
    fill_in "Currency", with: @account.currency
    fill_in "Deleted at", with: @account.deleted_at
    fill_in "Email", with: @account.email
    fill_in "Mobile", with: @account.mobile
    fill_in "Name", with: @account.name
    check "Notify emails" if @account.notify_emails
    fill_in "Parent", with: @account.parent_id
    fill_in "Postal code", with: @account.postal_code
    fill_in "Province", with: @account.province
    fill_in "Settings", with: @account.settings
    fill_in "String", with: @account.string
    fill_in "Timezone", with: @account.timezone
    click_on "Update Account"

    assert_text "Account was successfully updated"
    click_on "Back"
  end

  test "should destroy Account" do
    visit account_url(@account)
    click_on "Destroy this account", match: :first

    assert_text "Account was successfully destroyed"
  end
end
