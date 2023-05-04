# frozen_string_literal: true
Account.all.each do |account|
  ReceiptType.find_or_create_by!(name: 'Tuition Fee', account: account)
  ReceiptType.find_or_create_by!(name: 'Admission Fee', account: account)
end

if ENV.fetch("SEED_DATABASE").present? && true?(ENV.fetch("SEED_DATABASE"))
  if Rails.env.development?
    5.times do
      ReceiptType.find_or_create_by(
        name: Faker::Name.name, 
        account: Account.sample,
      )
    end
  end
end