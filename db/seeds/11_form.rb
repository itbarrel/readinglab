# frozen_string_literal: true

if ENV.fetch("SEED_DATABASE").present? && true?(ENV.fetch("SEED_DATABASE"))
  if Rails.env.development?
    5.times do
      Form.find_or_create_by(
        name: Faker::Name.first_name, 
        account: Account.sample,
      )
    end
  end
end
