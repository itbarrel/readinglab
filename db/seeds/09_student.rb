# frozen_string_literal: true
if Rails.env.development? && ENV['SEEDS_OFF']
  5.times do |index|
    Student.find_or_create_by!(
      first_name: Faker::Name.first_name, 
      last_name: Faker::Name.last_name, 
      school: 'saadschoolsystem',
      gender: (index %= 2)? 'male' : 'female',
      account: Account.sample,
      parent: Parent.sample
    )
  end
end

