Receipt.find_or_create_by(
  amount: 100,
  leave_count: 1,
  discount: 30,
  discount_reason: 'Student was on hold',
  sessions_count: 8,
  account: Account.sample,
  student: Student.sample,
  receipt_type: ReceiptType.sample
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