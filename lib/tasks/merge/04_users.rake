# frozen_string_literal: true

namespace :merge do
  desc 'Merges books to new tables'
  task users: :environment do
    Old::User.all.each do |old_user|
      User.find_or_create_by!(
        email: old_user.email,
        account_id: old_user.account_id
      ) do |user|
        user.id = old_user.id
        user.first_name = old_user.first
        user.last_name = old_user.last
        user.role = old_user.roles&.first.name
        user.password = ENV['DEFAULT_MERGE_PASSWORD']
        user.remember_created_at = old_user.remember_created_at
        user.sign_in_count = old_user.sign_in_count
        user.postal_code = old_user.postal_code
        user.phone = old_user.cell_phone
        user.emergency_name = old_user.emergency_name
        user.emergency_contact = old_user.emergency_phone
        user.date_of_hire = old_user.date_of_hire
        user.settings = old_user.settings
        user.undeletable = old_user.undeletable
        user.date_of_inactive = old_user.date_of_inactive
        user.external_user = old_user.external_user
        user.created_at = old_user.created_at
        user.updated_at = old_user.updated_at
        user.deleted_at = old_user.deleted_at
      end
    end
  end
end
