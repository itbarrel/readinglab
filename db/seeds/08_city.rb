# frozen_string_literal: true
cities = ['Lahore', 'Karachi', 'Islamabad']

cities.each do |c|
  City.find_or_create_by(
    name: c
  )
end
