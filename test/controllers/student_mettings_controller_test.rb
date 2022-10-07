# frozen_string_literal: true

require 'test_helper'

class StudentMettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student_metting = student_mettings(:one)
  end

  test 'should get index' do
    get student_mettings_url
    assert_response :success
  end

  test 'should get new' do
    get new_student_metting_url
    assert_response :success
  end

  test 'should create student_metting' do
    assert_difference('StudentMetting.count') do
      post student_mettings_url, params: { student_metting: {} }
    end

    assert_redirected_to student_metting_url(StudentMetting.last)
  end

  test 'should show student_metting' do
    get student_metting_url(@student_metting)
    assert_response :success
  end

  test 'should get edit' do
    get edit_student_metting_url(@student_metting)
    assert_response :success
  end

  test 'should update student_metting' do
    patch student_metting_url(@student_metting), params: { student_metting: {} }
    assert_redirected_to student_metting_url(@student_metting)
  end

  test 'should destroy student_metting' do
    assert_difference('StudentMetting.count', -1) do
      delete student_metting_url(@student_metting)
    end

    assert_redirected_to student_mettings_url
  end
end
