require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account = accounts(:one)
  end

  test "should get index" do
    get accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_account_url
    assert_response :success
  end

  test "should create account" do
    assert_difference("Account.count") do
      post accounts_url, params: { account: { account_types_id: @account.account_types_id, active: @account.active, address: @account.address, billing_scheme: @account.billing_scheme, country_code: @account.country_code, currency: @account.currency, deleted_at: @account.deleted_at, email: @account.email, mobile: @account.mobile, name: @account.name, notify_emails: @account.notify_emails, parent_id: @account.parent_id, postal_code: @account.postal_code, province: @account.province, settings: @account.settings, string: @account.string, timezone: @account.timezone } }
    end

    assert_redirected_to account_url(Account.last)
  end

  test "should show account" do
    get account_url(@account)
    assert_response :success
  end

  test "should get edit" do
    get edit_account_url(@account)
    assert_response :success
  end

  test "should update account" do
    patch account_url(@account), params: { account: { account_types_id: @account.account_types_id, active: @account.active, address: @account.address, billing_scheme: @account.billing_scheme, country_code: @account.country_code, currency: @account.currency, deleted_at: @account.deleted_at, email: @account.email, mobile: @account.mobile, name: @account.name, notify_emails: @account.notify_emails, parent_id: @account.parent_id, postal_code: @account.postal_code, province: @account.province, settings: @account.settings, string: @account.string, timezone: @account.timezone } }
    assert_redirected_to account_url(@account)
  end

  test "should destroy account" do
    assert_difference("Account.count", -1) do
      delete account_url(@account)
    end

    assert_redirected_to accounts_url
  end
end
