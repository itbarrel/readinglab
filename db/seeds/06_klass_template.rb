# frozen_string_literal: true

if ENV.fetch("SEED_DATABASE").present? && true?(ENV.fetch("SEED_DATABASE"))
  if Rails.env.development?
    5.times do
      KlassTemplate.find_or_create_by!(
        name: Faker::Name.name,
        monday: true,
        tuesday: true,
        wednesday: false,
        thursday: false,
        friday: false,
        saturday: false,
        sunday: false,
        teacher: Teacher.sample,
        room: Room.sample,
        account: Account.sample
      )
    end
  end
end
