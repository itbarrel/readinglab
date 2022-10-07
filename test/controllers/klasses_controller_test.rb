# frozen_string_literal: true

require 'test_helper'

class KlassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @klass = klasses(:one)
  end

  test 'should get index' do
    get klasses_url
    assert_response :success
  end

  test 'should get new' do
    get new_klass_url
    assert_response :success
  end

  test 'should create klass' do
    assert_difference('Klass.count') do
      post klasses_url,
           params: { klass: { account_id: @klass.account_id, active: @klass.active, deleted_at: @klass.deleted_at,
                              description: @klass.description, duration: @klass.duration, est_end_date: @klass.est_end_date, friday: @klass.friday, max_students: @klass.max_students, min_students: @klass.min_students, monday: @klass.monday, name: @klass.name, room_id: @klass.room_id, saturday: @klass.saturday, session_range: @klass.session_range, start: @klass.start, sunday: @klass.sunday, teacher_id: @klass.teacher_id, thursday: @klass.thursday, tuesday: @klass.tuesday, wednesday: @klass.wednesday } }
    end

    assert_redirected_to klass_url(Klass.last)
  end

  test 'should show klass' do
    get klass_url(@klass)
    assert_response :success
  end

  test 'should get edit' do
    get edit_klass_url(@klass)
    assert_response :success
  end

  test 'should update klass' do
    patch klass_url(@klass),
          params: { klass: { account_id: @klass.account_id, active: @klass.active, deleted_at: @klass.deleted_at,
                             description: @klass.description, duration: @klass.duration, est_end_date: @klass.est_end_date, friday: @klass.friday, max_students: @klass.max_students, min_students: @klass.min_students, monday: @klass.monday, name: @klass.name, room_id: @klass.room_id, saturday: @klass.saturday, session_range: @klass.session_range, start: @klass.start, sunday: @klass.sunday, teacher_id: @klass.teacher_id, thursday: @klass.thursday, tuesday: @klass.tuesday, wednesday: @klass.wednesday } }
    assert_redirected_to klass_url(@klass)
  end

  test 'should destroy klass' do
    assert_difference('Klass.count', -1) do
      delete klass_url(@klass)
    end

    assert_redirected_to klasses_url
  end
end
