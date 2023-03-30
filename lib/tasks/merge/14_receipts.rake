# frozen_string_literal: true

namespace :merge do
  desc 'Merges receipts to new tables'
  task receipts: :environment do
    Old::Receipt.all.each do |old_receipt|
      Receipt.find_or_create_by!(
        account_id: old_receipt.account_id,
        student_id: old_receipt.student_id,
        receipt_type_id: old_receipt.receipt_type_id
      ) do |receipt|
        receipt.id = old_receipt.id
        receipt.amount = old_receipt.amount
        receipt.discount = old_receipt.discount
        receipt.discount_reason = old_receipt.discount_reason
        receipt.sessions_count = old_receipt.sessions_count
        receipt.leave_count = old_receipt.leave_count
        receipt.created_at = old_receipt.created_at
        receipt.updated_at = old_receipt.updated_at
        receipt.deleted_at = old_receipt.deleted_at
      end
    rescue StandardError
      1 + 1
    end
    puts 'Successfully Merged Receipts.'
  end
end
