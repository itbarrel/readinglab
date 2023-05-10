# frozen_string_literal: true

namespace :merge do
  desc 'Merges books to new tables'
  task books: :environment do
    Old::Book.all.each do |old_book|
      Book.find_or_create_by!(
        account_id: old_book.account_id,
        name: old_book.name,
        klass_id: old_book.r_class_id
      ) do |book|
        book.id = old_book.id
        book.grade = old_book.grade
        book.created_at = old_book.created_at
        book.updated_at = old_book.updated_at
        book.deleted_at = (old_book.active)? old_book.deleted_at : old_book.updated_at
      end
    end
    puts 'Successfully Merged Books.'
  end
end
