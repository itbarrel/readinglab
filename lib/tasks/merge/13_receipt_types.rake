# frozen_string_literal: true

namespace :merge do
  desc 'Merges receipt_types to new tables'
  task receipt_types: :environment do
    Old::ReceiptType.all.each do |old_receipt_type|
      ReceiptType.find_or_create_by!(
        account_id: Old::Account.find_by(name: 'Vermont').id,
        name: old_receipt_type.name
      ) do |receipt_type|
        receipt_type.id = old_receipt_type.id
        receipt_type.created_at = old_receipt_type.created_at
        receipt_type.updated_at = old_receipt_type.updated_at
        receipt_type.deleted_at = old_receipt_type.active ? old_receipt_type.deleted_at : old_receipt_type.updated_at
      end
    end
    puts 'Successfully Merged Receipt Type.'
  end
end