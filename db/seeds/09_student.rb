# frozen_string_literal: true
if Rails.env.development?
  5.times do
    Student.find_or_create_by!(
      first_name: Faker::Name.first_name, 
      last_name: Faker::Name.last_name, 
      school: 'saadschoolsystem',
      account: Account.sample,
      parent: Parent.sample
    )
  end
end

