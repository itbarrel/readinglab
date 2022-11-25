# frozen_string_literal: true

5.times do
  Account.find_or_create_by(
    name: Faker::Name.name,
    currency: Faker::Currency.code,
    settings: { "date_format": 'dd/MM/yyyy' },
    billing_scheme: 'Sessionly',
    email: Faker::Internet.email,
    mobile: Faker::PhoneNumber.cell_phone,
    postal_code: Faker::Address.zip_code,
    account_type: AccountType.sample
  )
end
# Account.find_or_create_by(name: "Vermont", currency: "PKR", settings: '{"date_format": "dd/MM/yyyy"}',billing_scheme: "Sessionly")



# password: Faker::Internet.password(min_length: 8),