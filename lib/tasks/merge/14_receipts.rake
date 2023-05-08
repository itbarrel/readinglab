# frozen_string_literal: true

namespace :merge do
  desc 'Merges receipts to new tables'
  task receipts: :environment do
    Old::Receipt.find_each(batch_size: 100) do |old_receipt|
      Receipt.create!(
        account_id: old_receipt.account_id,
        student_id: old_receipt.student_id,
        receipt_type_id: old_receipt.receipt_type_id,
        id: old_receipt.id,
        amount: old_receipt.amount,
        discount: old_receipt.discount,
        discount_reason: old_receipt.discount_reason,
        sessions_count: old_receipt.sessions_count,
        leave_count: old_receipt.leave_count,
        created_at: old_receipt.created_at,
        updated_at: old_receipt.updated_at,
        deleted_at: old_receipt.deleted_at
      )
    rescue StandardError
      1 + 1
    end
    puts 'Successfully Merged Receipts.'
  end
end
