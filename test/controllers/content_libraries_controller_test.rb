require "test_helper"

class ContentLibrariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @content_library = content_libraries(:one)
  end

  test "should get index" do
    get content_libraries_url
    assert_response :success
  end

  test "should get new" do
    get new_content_library_url
    assert_response :success
  end

  test "should create content_library" do
    assert_difference("ContentLibrary.count") do
      post content_libraries_url, params: { content_library: { account_id: @content_library.account_id, active: @content_library.active, deleted_at: @content_library.deleted_at, public: @content_library.public, title: @content_library.title } }
    end

    assert_redirected_to content_library_url(ContentLibrary.last)
  end

  test "should show content_library" do
    get content_library_url(@content_library)
    assert_response :success
  end

  test "should get edit" do
    get edit_content_library_url(@content_library)
    assert_response :success
  end

  test "should update content_library" do
    patch content_library_url(@content_library), params: { content_library: { account_id: @content_library.account_id, active: @content_library.active, deleted_at: @content_library.deleted_at, public: @content_library.public, title: @content_library.title } }
    assert_redirected_to content_library_url(@content_library)
  end

  test "should destroy content_library" do
    assert_difference("ContentLibrary.count", -1) do
      delete content_library_url(@content_library)
    end

    assert_redirected_to content_libraries_url
  end
end
