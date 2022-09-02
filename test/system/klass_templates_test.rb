require "application_system_test_case"

class KlassTemplatesTest < ApplicationSystemTestCase
  setup do
    @klass_template = klass_templates(:one)
  end

  test "visiting the index" do
    visit klass_templates_url
    assert_selector "h1", text: "Klass templates"
  end

  test "should create klass template" do
    visit klass_templates_url
    click_on "New klass template"

    fill_in "Account", with: @klass_template.account_id
    check "Active" if @klass_template.active
    fill_in "Deleted at", with: @klass_template.deleted_at
    fill_in "Description", with: @klass_template.description
    fill_in "Duration", with: @klass_template.duration
    check "Friday" if @klass_template.friday
    fill_in "Max students", with: @klass_template.max_students
    fill_in "Min students", with: @klass_template.min_students
    check "Monday" if @klass_template.monday
    fill_in "Name", with: @klass_template.name
    fill_in "Room", with: @klass_template.room_id
    check "Saturday" if @klass_template.saturday
    fill_in "Session range", with: @klass_template.session_range
    fill_in "Settings", with: @klass_template.settings
    fill_in "Start", with: @klass_template.start
    check "Sunday" if @klass_template.sunday
    check "Thursday" if @klass_template.thursday
    check "Tuesday" if @klass_template.tuesday
    fill_in "User", with: @klass_template.user_id
    check "Wednesday" if @klass_template.wednesday
    click_on "Create Klass template"

    assert_text "Klass template was successfully created"
    click_on "Back"
  end

  test "should update Klass template" do
    visit klass_template_url(@klass_template)
    click_on "Edit this klass template", match: :first

    fill_in "Account", with: @klass_template.account_id
    check "Active" if @klass_template.active
    fill_in "Deleted at", with: @klass_template.deleted_at
    fill_in "Description", with: @klass_template.description
    fill_in "Duration", with: @klass_template.duration
    check "Friday" if @klass_template.friday
    fill_in "Max students", with: @klass_template.max_students
    fill_in "Min students", with: @klass_template.min_students
    check "Monday" if @klass_template.monday
    fill_in "Name", with: @klass_template.name
    fill_in "Room", with: @klass_template.room_id
    check "Saturday" if @klass_template.saturday
    fill_in "Session range", with: @klass_template.session_range
    fill_in "Settings", with: @klass_template.settings
    fill_in "Start", with: @klass_template.start
    check "Sunday" if @klass_template.sunday
    check "Thursday" if @klass_template.thursday
    check "Tuesday" if @klass_template.tuesday
    fill_in "User", with: @klass_template.user_id
    check "Wednesday" if @klass_template.wednesday
    click_on "Update Klass template"

    assert_text "Klass template was successfully updated"
    click_on "Back"
  end

  test "should destroy Klass template" do
    visit klass_template_url(@klass_template)
    click_on "Destroy this klass template", match: :first

    assert_text "Klass template was successfully destroyed"
  end
end
