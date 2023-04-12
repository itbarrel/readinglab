# frozen_string_literal: true
if Rails.env.development? && ENV['SEEDS_OFF']
  5.times do
    City.find_or_create_by(
      name: Faker::Name.name,
    )
  end
end
