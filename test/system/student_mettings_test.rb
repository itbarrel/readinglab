# frozen_string_literal: true

require 'application_system_test_case'

class StudentMettingsTest < ApplicationSystemTestCase
  setup do
    @student_metting = student_mettings(:one)
  end

  test 'visiting the index' do
    visit student_mettings_url
    assert_selector 'h1', text: 'Student mettings'
  end

  test 'should create student metting' do
    visit student_mettings_url
    click_on 'New student metting'

    click_on 'Create Student metting'

    assert_text 'Student metting was successfully created'
    click_on 'Back'
  end

  test 'should update Student metting' do
    visit student_metting_url(@student_metting)
    click_on 'Edit this student metting', match: :first

    click_on 'Update Student metting'

    assert_text 'Student metting was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Student metting' do
    visit student_metting_url(@student_metting)
    click_on 'Destroy this student metting', match: :first

    assert_text 'Student metting was successfully destroyed'
  end
end
