require "application_system_test_case"

class TrajectoryDetailsTest < ApplicationSystemTestCase
  setup do
    @trajectory_detail = trajectory_details(:one)
  end

  test "visiting the index" do
    visit trajectory_details_url
    assert_selector "h1", text: "Trajectory details"
  end

  test "should create trajectory detail" do
    visit trajectory_details_url
    click_on "New trajectory detail"

    fill_in "Account", with: @trajectory_detail.account_id
    check "Active" if @trajectory_detail.active
    fill_in "Book", with: @trajectory_detail.book_id
    fill_in "Deleted at", with: @trajectory_detail.deleted_at
    fill_in "Entry date", with: @trajectory_detail.entry_date
    fill_in "Error count", with: @trajectory_detail.error_count
    fill_in "Grade", with: @trajectory_detail.grade
    fill_in "Klass", with: @trajectory_detail.klass_id
    fill_in "Season", with: @trajectory_detail.season
    fill_in "User", with: @trajectory_detail.user_id
    fill_in "Wpm", with: @trajectory_detail.wpm
    click_on "Create Trajectory detail"

    assert_text "Trajectory detail was successfully created"
    click_on "Back"
  end

  test "should update Trajectory detail" do
    visit trajectory_detail_url(@trajectory_detail)
    click_on "Edit this trajectory detail", match: :first

    fill_in "Account", with: @trajectory_detail.account_id
    check "Active" if @trajectory_detail.active
    fill_in "Book", with: @trajectory_detail.book_id
    fill_in "Deleted at", with: @trajectory_detail.deleted_at
    fill_in "Entry date", with: @trajectory_detail.entry_date
    fill_in "Error count", with: @trajectory_detail.error_count
    fill_in "Grade", with: @trajectory_detail.grade
    fill_in "Klass", with: @trajectory_detail.klass_id
    fill_in "Season", with: @trajectory_detail.season
    fill_in "User", with: @trajectory_detail.user_id
    fill_in "Wpm", with: @trajectory_detail.wpm
    click_on "Update Trajectory detail"

    assert_text "Trajectory detail was successfully updated"
    click_on "Back"
  end

  test "should destroy Trajectory detail" do
    visit trajectory_detail_url(@trajectory_detail)
    click_on "Destroy this trajectory detail", match: :first

    assert_text "Trajectory detail was successfully destroyed"
  end
end
