# frozen_string_literal: true

require 'test_helper'

class TrajectoryDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trajectory_detail = trajectory_details(:one)
  end

  test 'should get index' do
    get trajectory_details_url
    assert_response :success
  end

  test 'should get new' do
    get new_trajectory_detail_url
    assert_response :success
  end

  test 'should create trajectory_detail' do
    assert_difference('TrajectoryDetail.count') do
      post trajectory_details_url,
           params: { trajectory_detail: { account_id: @trajectory_detail.account_id, active: @trajectory_detail.active,
                                          book_id: @trajectory_detail.book_id, deleted_at: @trajectory_detail.deleted_at, entry_date: @trajectory_detail.entry_date, error_count: @trajectory_detail.error_count, grade: @trajectory_detail.grade, klass_id: @trajectory_detail.klass_id, season: @trajectory_detail.season, user_id: @trajectory_detail.user_id, wpm: @trajectory_detail.wpm } }
    end

    assert_redirected_to trajectory_detail_url(TrajectoryDetail.last)
  end

  test 'should show trajectory_detail' do
    get trajectory_detail_url(@trajectory_detail)
    assert_response :success
  end

  test 'should get edit' do
    get edit_trajectory_detail_url(@trajectory_detail)
    assert_response :success
  end

  test 'should update trajectory_detail' do
    patch trajectory_detail_url(@trajectory_detail),
          params: { trajectory_detail: { account_id: @trajectory_detail.account_id, active: @trajectory_detail.active,
                                         book_id: @trajectory_detail.book_id, deleted_at: @trajectory_detail.deleted_at, entry_date: @trajectory_detail.entry_date, error_count: @trajectory_detail.error_count, grade: @trajectory_detail.grade, klass_id: @trajectory_detail.klass_id, season: @trajectory_detail.season, user_id: @trajectory_detail.user_id, wpm: @trajectory_detail.wpm } }
    assert_redirected_to trajectory_detail_url(@trajectory_detail)
  end

  test 'should destroy trajectory_detail' do
    assert_difference('TrajectoryDetail.count', -1) do
      delete trajectory_detail_url(@trajectory_detail)
    end

    assert_redirected_to trajectory_details_url
  end
end
