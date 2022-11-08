# frozen_string_literal: true

require 'application_system_test_case'

class KlassFormsTest < ApplicationSystemTestCase
  setup do
    @klass_form = klass_forms(:one)
  end

  test 'visiting the index' do
    visit klass_forms_url
    assert_selector 'h1', text: 'Klass forms'
  end

  test 'should create klass form' do
    visit klass_forms_url
    click_on 'New klass form'

    fill_in 'Deleted at', with: @klass_form.deleted_at
    fill_in 'Form', with: @klass_form.form_id
    fill_in 'Klass', with: @klass_form.klass_id
    click_on 'Create Klass form'

    assert_text 'Klass form was successfully created'
    click_on 'Back'
  end

  test 'should update Klass form' do
    visit klass_form_url(@klass_form)
    click_on 'Edit this klass form', match: :first

    fill_in 'Deleted at', with: @klass_form.deleted_at
    fill_in 'Form', with: @klass_form.form_id
    fill_in 'Klass', with: @klass_form.klass_id
    click_on 'Update Klass form'

    assert_text 'Klass form was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Klass form' do
    visit klass_form_url(@klass_form)
    click_on 'Destroy this klass form', match: :first

    assert_text 'Klass form was successfully destroyed'
  end
end
