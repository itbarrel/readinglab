require "application_system_test_case"

class VacationTypesTest < ApplicationSystemTestCase
  setup do
    @vacation_type = vacation_types(:one)
  end

  test "visiting the index" do
    visit vacation_types_url
    assert_selector "h1", text: "Vacation types"
  end

  test "should create vacation type" do
    visit vacation_types_url
    click_on "New vacation type"

    fill_in "Account", with: @vacation_type.account_id
    fill_in "Active", with: @vacation_type.active
    fill_in "Boolean", with: @vacation_type.boolean
    fill_in "Deleted at", with: @vacation_type.deleted_at
    fill_in "Description", with: @vacation_type.description
    fill_in "Name", with: @vacation_type.name
    fill_in "References", with: @vacation_type.references
    click_on "Create Vacation type"

    assert_text "Vacation type was successfully created"
    click_on "Back"
  end

  test "should update Vacation type" do
    visit vacation_type_url(@vacation_type)
    click_on "Edit this vacation type", match: :first

    fill_in "Account", with: @vacation_type.account_id
    fill_in "Active", with: @vacation_type.active
    fill_in "Boolean", with: @vacation_type.boolean
    fill_in "Deleted at", with: @vacation_type.deleted_at
    fill_in "Description", with: @vacation_type.description
    fill_in "Name", with: @vacation_type.name
    fill_in "References", with: @vacation_type.references
    click_on "Update Vacation type"

    assert_text "Vacation type was successfully updated"
    click_on "Back"
  end

  test "should destroy Vacation type" do
    visit vacation_type_url(@vacation_type)
    click_on "Destroy this vacation type", match: :first

    assert_text "Vacation type was successfully destroyed"
  end
end
