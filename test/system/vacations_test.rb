require "application_system_test_case"

class VacationsTest < ApplicationSystemTestCase
  setup do
    @vacation = vacations(:one)
  end

  test "visiting the index" do
    visit vacations_url
    assert_selector "h1", text: "Vacations"
  end

  test "should create vacation" do
    visit vacations_url
    click_on "New vacation"

    fill_in "Account", with: @vacation.account_id
    fill_in "Active", with: @vacation.active
    fill_in "Boolean", with: @vacation.boolean
    fill_in "Day", with: @vacation.day
    fill_in "Deleted at", with: @vacation.deleted_at
    fill_in "Ending at", with: @vacation.ending_at
    fill_in "Name", with: @vacation.name
    fill_in "References", with: @vacation.references
    fill_in "Strating at", with: @vacation.strating_at
    fill_in "Vacation type", with: @vacation.vacation_type
    click_on "Create Vacation"

    assert_text "Vacation was successfully created"
    click_on "Back"
  end

  test "should update Vacation" do
    visit vacation_url(@vacation)
    click_on "Edit this vacation", match: :first

    fill_in "Account", with: @vacation.account_id
    fill_in "Active", with: @vacation.active
    fill_in "Boolean", with: @vacation.boolean
    fill_in "Day", with: @vacation.day
    fill_in "Deleted at", with: @vacation.deleted_at
    fill_in "Ending at", with: @vacation.ending_at
    fill_in "Name", with: @vacation.name
    fill_in "References", with: @vacation.references
    fill_in "Strating at", with: @vacation.strating_at
    fill_in "Vacation type", with: @vacation.vacation_type
    click_on "Update Vacation"

    assert_text "Vacation was successfully updated"
    click_on "Back"
  end

  test "should destroy Vacation" do
    visit vacation_url(@vacation)
    click_on "Destroy this vacation", match: :first

    assert_text "Vacation was successfully destroyed"
  end
end
