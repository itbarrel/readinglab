# frozen_string_literal: true

namespace :merge do
  desc 'Merges message_templates to new tables'
  task message_templates: :environment do
    Old::LibraryMessage.all do |old_library_message|
      MessageTemplate.find_or_create_by!(
        name: old_library_message.name,
        account_id: old_library_message.account_id
      ) do |message|
        message.id = old_library_message.id
        message.description = old_library_message.description
        message.created_at = old_library_message.created_at
        message.updated_at = old_library_message.updated_at
        message.deleted_at = old_library_message.deleted_at
      end
    end
  end
end
