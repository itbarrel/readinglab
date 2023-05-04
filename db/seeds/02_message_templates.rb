# frozen_string_literal: true

if ENV.fetch("SEED_DATABASE").present? && true?(ENV.fetch("SEED_DATABASE"))
  MessageTemplate.find_or_create_by(
    account: Account.sample,
    name: 'Calling',
    description: 'Calling you back!!'
  )

  if Rails.env.development?
    5.times do |index|
      MessageTemplate.find_or_create_by!(name: "Calling_#{index}", description: Faker::Name.name, account: Account.sample)
    end
  end
end
