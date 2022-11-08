# frozen_string_literal: true

require 'test_helper'

class KlassTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @klass_template = klass_templates(:one)
  end

  test 'should get index' do
    get klass_templates_url
    assert_response :success
  end

  test 'should get new' do
    get new_klass_template_url
    assert_response :success
  end

  test 'should create klass_template' do
    assert_difference('KlassTemplate.count') do
      post klass_templates_url,
           params: { klass_template: { account_id: @klass_template.account_id, active: @klass_template.active,
                                       deleted_at: @klass_template.deleted_at, description: @klass_template.description, duration: @klass_template.duration, friday: @klass_template.friday, max_students: @klass_template.max_students, min_students: @klass_template.min_students, monday: @klass_template.monday, name: @klass_template.name, room_id: @klass_template.room_id, saturday: @klass_template.saturday, session_range: @klass_template.session_range, settings: @klass_template.settings, start: @klass_template.start, sunday: @klass_template.sunday, thursday: @klass_template.thursday, tuesday: @klass_template.tuesday, user_id: @klass_template.user_id, wednesday: @klass_template.wednesday } }
    end

    assert_redirected_to klass_template_url(KlassTemplate.last)
  end

  test 'should show klass_template' do
    get klass_template_url(@klass_template)
    assert_response :success
  end

  test 'should get edit' do
    get edit_klass_template_url(@klass_template)
    assert_response :success
  end

  test 'should update klass_template' do
    patch klass_template_url(@klass_template),
          params: { klass_template: { account_id: @klass_template.account_id, active: @klass_template.active,
                                      deleted_at: @klass_template.deleted_at, description: @klass_template.description, duration: @klass_template.duration, friday: @klass_template.friday, max_students: @klass_template.max_students, min_students: @klass_template.min_students, monday: @klass_template.monday, name: @klass_template.name, room_id: @klass_template.room_id, saturday: @klass_template.saturday, session_range: @klass_template.session_range, settings: @klass_template.settings, start: @klass_template.start, sunday: @klass_template.sunday, thursday: @klass_template.thursday, tuesday: @klass_template.tuesday, user_id: @klass_template.user_id, wednesday: @klass_template.wednesday } }
    assert_redirected_to klass_template_url(@klass_template)
  end

  test 'should destroy klass_template' do
    assert_difference('KlassTemplate.count', -1) do
      delete klass_template_url(@klass_template)
    end

    assert_redirected_to klass_templates_url
  end
end
