# frozen_string_literal: true

if ENV.fetch("SEED_DATABASE").present? && true?(ENV.fetch("SEED_DATABASE"))
  if Rails.env.development?
    5.times do |index|
      Student.find_or_create_by!(
        first_name: Faker::Name.first_name, 
        last_name: Faker::Name.last_name, 
        school: 'atchison',
        gender: (index %= 2)? 'male' : 'female',
        account: Account.sample,
        parent: Parent.sample
      )
    end
  end
end
