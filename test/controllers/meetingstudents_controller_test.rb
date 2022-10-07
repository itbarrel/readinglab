# frozen_string_literal: true

require 'test_helper'

class MeetingstudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meetingstudent = meetingstudents(:one)
  end

  test 'should get index' do
    get meetingstudents_url
    assert_response :success
  end

  test 'should get new' do
    get new_meetingstudent_url
    assert_response :success
  end

  test 'should create meetingstudent' do
    assert_difference('Meetingstudent.count') do
      post meetingstudents_url,
           params: { meetingstudent: { account_id: @meetingstudent.account_id, active: @meetingstudent.active,
                                       attended: @meetingstudent.attended, deleted_at: @meetingstudent.deleted_at, meeting_id: @meetingstudent.meeting_id, user_id: @meetingstudent.user_id } }
    end

    assert_redirected_to meetingstudent_url(Meetingstudent.last)
  end

  test 'should show meetingstudent' do
    get meetingstudent_url(@meetingstudent)
    assert_response :success
  end

  test 'should get edit' do
    get edit_meetingstudent_url(@meetingstudent)
    assert_response :success
  end

  test 'should update meetingstudent' do
    patch meetingstudent_url(@meetingstudent),
          params: { meetingstudent: { account_id: @meetingstudent.account_id, active: @meetingstudent.active,
                                      attended: @meetingstudent.attended, deleted_at: @meetingstudent.deleted_at, meeting_id: @meetingstudent.meeting_id, user_id: @meetingstudent.user_id } }
    assert_redirected_to meetingstudent_url(@meetingstudent)
  end

  test 'should destroy meetingstudent' do
    assert_difference('Meetingstudent.count', -1) do
      delete meetingstudent_url(@meetingstudent)
    end

    assert_redirected_to meetingstudents_url
  end
end
