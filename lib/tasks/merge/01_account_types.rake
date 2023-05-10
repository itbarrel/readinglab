# frozen_string_literal: true

namespace :merge do
  desc 'Merges old Account types to new tables'

  task account_types: :environment do
    old_account_types = Old::AccountType.all
    old_account_types.each do |old_account_type|
      AccountType.find_or_create_by!(
        name: old_account_type.name
      ) do |account_type|
        account_type.id = old_account_type.id
        account_type.created_at = old_account_type.created_at
        account_type.updated_at = old_account_type.updated_at
        account_type.deleted_at = old_account_type.deleted_at
      end
    end

    return unless old_account_types.length == AccountType.count

    puts 'Successfully Merged Account Types.'
  end
end
