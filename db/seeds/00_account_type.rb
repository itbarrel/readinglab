# frozen_string_literal: true


if ENV.fetch("SEED_DATABASE").present? && true?(ENV.fetch("SEED_DATABASE"))
  AccountType.find_or_create_by!(name: 'School')
  AccountType.find_or_create_by!(name: 'External Organization')

  if Rails.env.development?
    5.times do |x|
      AccountType.find_or_create_by!(name: Faker::Company.bs)
    end
  end
end
