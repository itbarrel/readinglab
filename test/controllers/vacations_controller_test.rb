require "test_helper"

class VacationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vacation = vacations(:one)
  end

  test "should get index" do
    get vacations_url
    assert_response :success
  end

  test "should get new" do
    get new_vacation_url
    assert_response :success
  end

  test "should create vacation" do
    assert_difference("Vacation.count") do
      post vacations_url, params: { vacation: { account_id: @vacation.account_id, active: @vacation.active, boolean: @vacation.boolean, day: @vacation.day, deleted_at: @vacation.deleted_at, ending_at: @vacation.ending_at, name: @vacation.name, references: @vacation.references, strating_at: @vacation.strating_at, vacation_type: @vacation.vacation_type } }
    end

    assert_redirected_to vacation_url(Vacation.last)
  end

  test "should show vacation" do
    get vacation_url(@vacation)
    assert_response :success
  end

  test "should get edit" do
    get edit_vacation_url(@vacation)
    assert_response :success
  end

  test "should update vacation" do
    patch vacation_url(@vacation), params: { vacation: { account_id: @vacation.account_id, active: @vacation.active, boolean: @vacation.boolean, day: @vacation.day, deleted_at: @vacation.deleted_at, ending_at: @vacation.ending_at, name: @vacation.name, references: @vacation.references, strating_at: @vacation.strating_at, vacation_type: @vacation.vacation_type } }
    assert_redirected_to vacation_url(@vacation)
  end

  test "should destroy vacation" do
    assert_difference("Vacation.count", -1) do
      delete vacation_url(@vacation)
    end

    assert_redirected_to vacations_url
  end
end
