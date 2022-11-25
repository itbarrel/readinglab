# frozen_string_literal: true

5.times do
    City.find_or_create_by(
        name: Faker::Name.name,
        )
end


