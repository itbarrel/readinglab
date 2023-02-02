# frozen_string_literal: true

MessageTemplate.find_or_create_by(
  account_id: Account.last.id,
  name: 'Calling',
  description: 'Calling you back!!'
)

if Rails.env.development?
  5.times do |index|
    MessageTemplate.find_or_create_by!(
      name: "Calling_#{index}",
      description: Faker::Name.name,
      account: Account.sample
    )
  end
end
