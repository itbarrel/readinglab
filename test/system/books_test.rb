# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: 'Books'
  end

  test 'should create book' do
    visit books_url
    click_on 'New book'

    fill_in 'Account', with: @book.account_id
    check 'Active' if @book.active
    fill_in 'Deleted at', with: @book.deleted_at
    fill_in 'Grade', with: @book.grade
    fill_in 'Klass', with: @book.klass_id
    fill_in 'Name', with: @book.name
    click_on 'Create Book'

    assert_text 'Book was successfully created'
    click_on 'Back'
  end

  test 'should update Book' do
    visit book_url(@book)
    click_on 'Edit this book', match: :first

    fill_in 'Account', with: @book.account_id
    check 'Active' if @book.active
    fill_in 'Deleted at', with: @book.deleted_at
    fill_in 'Grade', with: @book.grade
    fill_in 'Klass', with: @book.klass_id
    fill_in 'Name', with: @book.name
    click_on 'Update Book'

    assert_text 'Book was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Book' do
    visit book_url(@book)
    click_on 'Destroy this book', match: :first

    assert_text 'Book was successfully destroyed'
  end
end
