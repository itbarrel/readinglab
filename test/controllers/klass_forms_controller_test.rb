# frozen_string_literal: true

require 'test_helper'

class KlassFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @klass_form = klass_forms(:one)
  end

  test 'should get index' do
    get klass_forms_url
    assert_response :success
  end

  test 'should get new' do
    get new_klass_form_url
    assert_response :success
  end

  test 'should create klass_form' do
    assert_difference('KlassForm.count') do
      post klass_forms_url,
           params: { klass_form: { deleted_at: @klass_form.deleted_at, form_id: @klass_form.form_id,
                                   klass_id: @klass_form.klass_id } }
    end

    assert_redirected_to klass_form_url(KlassForm.last)
  end

  test 'should show klass_form' do
    get klass_form_url(@klass_form)
    assert_response :success
  end

  test 'should get edit' do
    get edit_klass_form_url(@klass_form)
    assert_response :success
  end

  test 'should update klass_form' do
    patch klass_form_url(@klass_form),
          params: { klass_form: { deleted_at: @klass_form.deleted_at, form_id: @klass_form.form_id,
                                  klass_id: @klass_form.klass_id } }
    assert_redirected_to klass_form_url(@klass_form)
  end

  test 'should destroy klass_form' do
    assert_difference('KlassForm.count', -1) do
      delete klass_form_url(@klass_form)
    end

    assert_redirected_to klass_forms_url
  end
end
