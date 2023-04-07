# frozen_string_literal: true

User.find_or_create_by!(
  first_name: 'Super',
  last_name: 'Admin',
  email: 'super_admin@readinglab.co',
  role: :super_admin,
  account: Account.sample
)
.update(password: '12345678')

User.find_or_create_by!(
  first_name: 'Senior',
  last_name: 'Admin',
  email: 'support@readinglab.co',
  role: :admin,
  account: Account.sample
)
.update(password: 'reading123')

User.find_or_create_by!(
  first_name: 'Junior',
  last_name: 'Admin',
  email: 'admin_junior@readinglab.co',
  role: :admin_junior,
  account: Account.sample
)
.update(password: 'reading123')

User.find_or_create_by!(
  first_name: 'Super',
  last_name: 'Visor',
  email: 'supervisor@readinglab.co',
  role: :supervisor,
  account: Account.sample
)
.update(password: 'reading123')

if Rails.env.development?
  5.times do
    User.find_or_create_by!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      account: Account.sample,
      role: User.roles.keys.sample
    )
    .update(password: '12345678')
  end
end
