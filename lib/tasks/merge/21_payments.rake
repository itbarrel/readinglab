# frozen_string_literal: true

namespace :merge do
  desc 'Merges payments to new tables'
  task payments: :environment do
    students = {}

    Student.all.each do |x|
      students[x.id] = true
    end

    meetings = {}

    Meeting.all.each do |x|
      meetings[x.id] = true
    end

    receipts = {}

    Receipt.all.each do |x|
      receipts[x.id] = true
    end

    Old::PaidStudentSession.find_each(batch_size: 200).each do |old_payment|
      next unless students[old_payment.student_id] && meetings[old_payment.meeting_id]  && receipts[old_payment.meeting_id]

      Payment.create!(
        student_id: old_payment.student_id,
        receipt_id: old_payment.receipt_id,
        meeting_id: old_payment.meeting_id
      )
    end
    puts 'Successfully Merged Payments.'
  end
end
