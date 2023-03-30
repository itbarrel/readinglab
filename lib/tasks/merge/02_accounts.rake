# frozen_string_literal: true

namespace :merge do
  desc 'Merges old Account to new tables'
  task accounts: :environment do
    Old::Account.all.each do |old_account|
      # Required associations
      account_types = if old_account.account_types.empty?
                        AccountType.where(name: AccountType.default_seeds)
                      else
                        old_account.account_types
                      end

      account_types.each do |at|
        Account.find_or_create_by(
          name: old_account.name,
          email: old_account.email || 'support@yopmail.com',
          mobile: old_account.mobile || '03123456789',
          postal_code: old_account.postal_code || '54321',
          account_type_id: at.id
        ) do |account|
          account.id = old_account.id
          account.currency = old_account.currency
          account.settings = old_account.settings
          account.address = old_account.address
          account.timezone = old_account.timezone
          account.province = old_account.province
          account.country_code = old_account.country_code
          account.billing_scheme = old_account.billing_scheme
          account.notify_emails = old_account.send_emails
          account.parent_id = old_account.parent_id
        end
      end
    end
    puts 'Successfully Merged Accounts.'
  end
end
