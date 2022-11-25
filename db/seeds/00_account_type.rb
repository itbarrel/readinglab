# frozen_string_literal: true

AccountType.find_or_create_by!(name: 'School')
AccountType.find_or_create_by!(name: 'External Organization')

5.times do |x|
  AccountType.find_or_create_by!(name: Faker::Company.bs)
end
