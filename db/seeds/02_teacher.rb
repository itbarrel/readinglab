# frozen_string_literal: true

user = Teacher.find_or_create_by(account_id: Account.last.id, email: 'teacher@readinglab.co',
                               first_name: 'Teacher', last_name: 'Heavy') do |user|
  user.password = '12345678'
end

if Rails.env.development?
  5.times do
    Teacher.find_or_create_by!(
      first_name: Faker::Name.first_name ,
      last_name: Faker::Name.last_name ,
      email: Faker::Internet.email,
      account: Account.sample,
    ) do |user|
      user.password = '12345678'
    end
  end
end
