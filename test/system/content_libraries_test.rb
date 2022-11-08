# frozen_string_literal: true

require 'application_system_test_case'

class ContentLibrariesTest < ApplicationSystemTestCase
  setup do
    @content_library = content_libraries(:one)
  end

  test 'visiting the index' do
    visit content_libraries_url
    assert_selector 'h1', text: 'Content libraries'
  end

  test 'should create content library' do
    visit content_libraries_url
    click_on 'New content library'

    fill_in 'Account', with: @content_library.account_id
    check 'Active' if @content_library.active
    fill_in 'Deleted at', with: @content_library.deleted_at
    check 'Public' if @content_library.public
    fill_in 'Title', with: @content_library.title
    click_on 'Create Content library'

    assert_text 'Content library was successfully created'
    click_on 'Back'
  end

  test 'should update Content library' do
    visit content_library_url(@content_library)
    click_on 'Edit this content library', match: :first

    fill_in 'Account', with: @content_library.account_id
    check 'Active' if @content_library.active
    fill_in 'Deleted at', with: @content_library.deleted_at
    check 'Public' if @content_library.public
    fill_in 'Title', with: @content_library.title
    click_on 'Update Content library'

    assert_text 'Content library was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Content library' do
    visit content_library_url(@content_library)
    click_on 'Destroy this content library', match: :first

    assert_text 'Content library was successfully destroyed'
  end
end
