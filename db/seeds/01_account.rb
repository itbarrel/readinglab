# frozen_string_literal: true

Account.find_or_create_by(
  name: 'Super',
  currency: 'PKR',
  settings: { "date_format": 'dd/MM/yyyy' },
  billing_scheme: 'Sessionly',
  email: 'mishal@gmail.com',
  mobile: '333333',
  postal_code: '234',
  account_type: AccountType.last
)
# Account.find_or_create_by(name: "Vermont", currency: "PKR", settings: '{"date_format": "dd/MM/yyyy"}',billing_scheme: "Sessionly")
