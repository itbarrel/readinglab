# frozen_string_literal: true

if ENV.fetch("SEED_DATABASE").present? && true?(ENV.fetch("SEED_DATABASE"))
  Room.find_or_create_by!(name: 'room 1', capacity: 22, account: Account.sample)
  Room.find_or_create_by!(name: 'room 2', capacity: 24, color: 'black', account: Account.sample)
  Room.find_or_create_by!(name: 'room 3', capacity: 24, color: 'black', account: Account.sample)
  Room.find_or_create_by!(name: 'room 4', capacity: 24, color: 'black', account: Account.sample)
  Room.find_or_create_by!(name: 'room 5', capacity: 24, color: 'black', account: Account.sample)
  
  if Rails.env.development?
    5.times do
      Room.find_or_create_by!(
        name: Faker::Name.first_name,
        capacity: Faker::Number.number(digits: 2),
        color: Faker::Color.hex_color, #=> "#31a785"
        account: Account.sample,
      )
    end
  end
end
