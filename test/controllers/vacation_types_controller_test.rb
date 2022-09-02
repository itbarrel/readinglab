require "test_helper"

class VacationTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vacation_type = vacation_types(:one)
  end

  test "should get index" do
    get vacation_types_url
    assert_response :success
  end

  test "should get new" do
    get new_vacation_type_url
    assert_response :success
  end

  test "should create vacation_type" do
    assert_difference("VacationType.count") do
      post vacation_types_url, params: { vacation_type: { account_id: @vacation_type.account_id, active: @vacation_type.active, boolean: @vacation_type.boolean, deleted_at: @vacation_type.deleted_at, description: @vacation_type.description, name: @vacation_type.name, references: @vacation_type.references } }
    end

    assert_redirected_to vacation_type_url(VacationType.last)
  end

  test "should show vacation_type" do
    get vacation_type_url(@vacation_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_vacation_type_url(@vacation_type)
    assert_response :success
  end

  test "should update vacation_type" do
    patch vacation_type_url(@vacation_type), params: { vacation_type: { account_id: @vacation_type.account_id, active: @vacation_type.active, boolean: @vacation_type.boolean, deleted_at: @vacation_type.deleted_at, description: @vacation_type.description, name: @vacation_type.name, references: @vacation_type.references } }
    assert_redirected_to vacation_type_url(@vacation_type)
  end

  test "should destroy vacation_type" do
    assert_difference("VacationType.count", -1) do
      delete vacation_type_url(@vacation_type)
    end

    assert_redirected_to vacation_types_url
  end
end
