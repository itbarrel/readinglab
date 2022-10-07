# frozen_string_literal: true

require 'application_system_test_case'

class KlassTempelateFormsTest < ApplicationSystemTestCase
  setup do
    @klass_tempelate_form = klass_tempelate_forms(:one)
  end

  test 'visiting the index' do
    visit klass_tempelate_forms_url
    assert_selector 'h1', text: 'Klass tempelate forms'
  end

  test 'should create klass tempelate form' do
    visit klass_tempelate_forms_url
    click_on 'New klass tempelate form'

    fill_in 'Deleted at', with: @klass_tempelate_form.deleted_at
    fill_in 'Form', with: @klass_tempelate_form.form_id
    fill_in 'Klass tempelate', with: @klass_tempelate_form.klass_tempelate_id
    click_on 'Create Klass tempelate form'

    assert_text 'Klass tempelate form was successfully created'
    click_on 'Back'
  end

  test 'should update Klass tempelate form' do
    visit klass_tempelate_form_url(@klass_tempelate_form)
    click_on 'Edit this klass tempelate form', match: :first

    fill_in 'Deleted at', with: @klass_tempelate_form.deleted_at
    fill_in 'Form', with: @klass_tempelate_form.form_id
    fill_in 'Klass tempelate', with: @klass_tempelate_form.klass_tempelate_id
    click_on 'Update Klass tempelate form'

    assert_text 'Klass tempelate form was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Klass tempelate form' do
    visit klass_tempelate_form_url(@klass_tempelate_form)
    click_on 'Destroy this klass tempelate form', match: :first

    assert_text 'Klass tempelate form was successfully destroyed'
  end
end
