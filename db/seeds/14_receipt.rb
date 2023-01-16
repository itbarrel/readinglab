Receipt.find_or_create_by(
  amount: 1,
  leave_count: 1,
  discount: 1,
  discount_reason: '',
  sessions_count: 1,
  account: Account.last,
  student: Student.last,
  receipt_type: ReceiptType.last
)

if Rails.env.development?
  5.times do
    Receipt.find_or_create_by(
      amount: Faker::Number.number(digits: 1),
      leave_count: Faker::Number.number(digits: 1), 
      sessions_count: Faker::Number.number(digits: 1), 
      discount: Faker::Number.number(digits: 2), 
      discount_reason: '', 
      account: Account.sample,
      student: Student.sample,
      receipt_type: ReceiptType.sample

    )
  end
end