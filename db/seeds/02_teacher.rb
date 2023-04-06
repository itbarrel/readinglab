# frozen_string_literal: true

Teacher.find_or_create_by!(
  first_name: 'Teacher',
  last_name: 'Heavy',
  email: 'teacher@readinglab.co',
  account: Account.sample
)
.update(password: '12345678')

if Rails.env.development?
  5.times do
    Teacher.find_or_create_by!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      account: Account.sample
    )
    .update(password: '12345678')
  end
end
