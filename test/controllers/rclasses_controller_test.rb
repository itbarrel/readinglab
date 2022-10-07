# frozen_string_literal: true

require 'test_helper'

class RclassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rclass = rclasses(:one)
  end

  test 'should get index' do
    get rclasses_url
    assert_response :success
  end

  test 'should get new' do
    get new_rclass_url
    assert_response :success
  end

  test 'should create rclass' do
    assert_difference('Rclass.count') do
      post rclasses_url,
           params: { rclass: { account_id: @rclass.account_id, active: @rclass.active, deleted_at: @rclass.deleted_at,
                               description: @rclass.description, duration: @rclass.duration, est_end_date: @rclass.est_end_date, friday: @rclass.friday, max_students: @rclass.max_students, min_students: @rclass.min_students, monday: @rclass.monday, name: @rclass.name, room_id: @rclass.room_id, saturday: @rclass.saturday, session_range: @rclass.session_range, start: @rclass.start, sunday: @rclass.sunday, thursday: @rclass.thursday, tuesday: @rclass.tuesday, user_id: @rclass.user_id, wednesday: @rclass.wednesday } }
    end

    assert_redirected_to rclass_url(Rclass.last)
  end

  test 'should show rclass' do
    get rclass_url(@rclass)
    assert_response :success
  end

  test 'should get edit' do
    get edit_rclass_url(@rclass)
    assert_response :success
  end

  test 'should update rclass' do
    patch rclass_url(@rclass),
          params: { rclass: { account_id: @rclass.account_id, active: @rclass.active, deleted_at: @rclass.deleted_at,
                              description: @rclass.description, duration: @rclass.duration, est_end_date: @rclass.est_end_date, friday: @rclass.friday, max_students: @rclass.max_students, min_students: @rclass.min_students, monday: @rclass.monday, name: @rclass.name, room_id: @rclass.room_id, saturday: @rclass.saturday, session_range: @rclass.session_range, start: @rclass.start, sunday: @rclass.sunday, thursday: @rclass.thursday, tuesday: @rclass.tuesday, user_id: @rclass.user_id, wednesday: @rclass.wednesday } }
    assert_redirected_to rclass_url(@rclass)
  end

  test 'should destroy rclass' do
    assert_difference('Rclass.count', -1) do
      delete rclass_url(@rclass)
    end

    assert_redirected_to rclasses_url
  end
end
