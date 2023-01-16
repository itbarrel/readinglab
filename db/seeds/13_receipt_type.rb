ReceiptType.find_or_create_by!(name: 'School', account: Account.last)
ReceiptType.find_or_create_by!(name: 'External Organization', account: Account.last)

if Rails.env.development?
  5.times do
    ReceiptType.find_or_create_by(
      name: Faker::Name.name, 
      account: Account.sample,
    )
  end
end