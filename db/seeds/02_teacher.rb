# frozen_string_literal: true

if ENV.fetch("SEED_DATABASE").present? && true?(ENV.fetch("SEED_DATABASE"))
  Teacher.find_or_create_by!(
    first_name: 'Teacher',
    last_name: 'Heavy',
    email: 'teacher@readinglab.co',
    account: Account.sample
  ) do |user|
    user.password = '12345678'
  end
  
  if Rails.env.development?
    5.times do
      Teacher.find_or_create_by!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        account: Account.sample
      ) do |user|
        user.password = '12345678'
      end
    end
  end
end
