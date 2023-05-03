# frozen_string_literal: true

if Rails.env.development? && ENV['SEEDS_OFF']
  cities = ['Lahore', 'Karachi', 'Islamabad']

  cities.each do |c|
    City.find_or_create_by(
      name: c
    )
  end
end
