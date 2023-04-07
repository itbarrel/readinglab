ReceiptType.find_or_create_by!(name: 'Tuition Fee', account: Account.sample)
ReceiptType.find_or_create_by!(name: 'Admission Fee', account: Account.sample)

if Rails.env.development?
  5.times do
    ReceiptType.find_or_create_by(
      name: Faker::Name.name, 
      account: Account.sample,
    )
  end
end