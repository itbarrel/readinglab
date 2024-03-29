# frozen_string_literal: true

account = Account.sample
if account.present?
  User.find_or_create_by!(
    first_name: 'Super',
    last_name: 'Admin',
    email: 'super_admin@readinglab.co',
    role: :super_admin,
    account: account
  ) do |user|
    user.password = '12345678'
  end
end

if ENV.fetch("SEED_DATABASE").present? && true?(ENV.fetch("SEED_DATABASE"))
  User.find_or_create_by!(
    first_name: 'Senior',
    last_name: 'Admin',
    email: 'support@readinglab.co',
    role: :admin,
    account: Account.sample
  ) do |user|
    user.password = '12345678'
  end

  User.find_or_create_by!(
    first_name: 'Super',
    last_name: 'Visor',
    email: 'supervisor@readinglab.co',
    role: :supervisor,
    account: Account.sample
  ) do |user|
    user.password = '12345678'
  end

  if Rails.env.development?
    5.times do
      User.find_or_create_by!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        account: Account.sample,
        role: User.roles.keys.sample
      ) do |user|
        user.password = '12345678'
      end
    end
  end
end
