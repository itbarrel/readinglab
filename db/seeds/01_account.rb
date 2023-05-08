# frozen_string_literal: true

if ENV.fetch("SEED_DATABASE").present? && true?(ENV.fetch("SEED_DATABASE"))
  Account.find_or_create_by(
    name: "Vermont",
    currency: "PKR",
    settings: { "date_format": "dd/MM/yyyy" },
    billing_scheme: :sessionly,
    postal_code: 54000,
    email: 'readinglab@gmail.com',
    mobile: '03350477406',
    account_type: AccountType.sample
  )

  if Rails.env.development?
    5.times do
      Account.find_or_create_by(
        name: Faker::Name.name,
        currency: Faker::Currency.code,
        settings: { "date_format": 'dd/MM/yyyy' },
        billing_scheme: 'sessionly',
        email: Faker::Internet.email,
        mobile: Faker::PhoneNumber.cell_phone,
        postal_code: Faker::Address.zip_code,
        account_type: AccountType.sample
      )
    end
  end
end

# password: Faker::Internet.password(min_length: 8),
