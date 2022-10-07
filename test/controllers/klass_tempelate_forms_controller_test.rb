# frozen_string_literal: true

require 'test_helper'

class KlassTempelateFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @klass_tempelate_form = klass_tempelate_forms(:one)
  end

  test 'should get index' do
    get klass_tempelate_forms_url
    assert_response :success
  end

  test 'should get new' do
    get new_klass_tempelate_form_url
    assert_response :success
  end

  test 'should create klass_tempelate_form' do
    assert_difference('KlassTempelateForm.count') do
      post klass_tempelate_forms_url,
           params: { klass_tempelate_form: { deleted_at: @klass_tempelate_form.deleted_at, form_id: @klass_tempelate_form.form_id,
                                             klass_tempelate_id: @klass_tempelate_form.klass_tempelate_id } }
    end

    assert_redirected_to klass_tempelate_form_url(KlassTempelateForm.last)
  end

  test 'should show klass_tempelate_form' do
    get klass_tempelate_form_url(@klass_tempelate_form)
    assert_response :success
  end

  test 'should get edit' do
    get edit_klass_tempelate_form_url(@klass_tempelate_form)
    assert_response :success
  end

  test 'should update klass_tempelate_form' do
    patch klass_tempelate_form_url(@klass_tempelate_form),
          params: { klass_tempelate_form: { deleted_at: @klass_tempelate_form.deleted_at, form_id: @klass_tempelate_form.form_id,
                                            klass_tempelate_id: @klass_tempelate_form.klass_tempelate_id } }
    assert_redirected_to klass_tempelate_form_url(@klass_tempelate_form)
  end

  test 'should destroy klass_tempelate_form' do
    assert_difference('KlassTempelateForm.count', -1) do
      delete klass_tempelate_form_url(@klass_tempelate_form)
    end

    assert_redirected_to klass_tempelate_forms_url
  end
end
