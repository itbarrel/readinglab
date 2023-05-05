# frozen_string_literal: true

if ENV.fetch("SEED_DATABASE").present? && true?(ENV.fetch("SEED_DATABASE"))
  if Rails.env.development?
    5.times do
      Klass.find_or_create_by!(
        starts_at: Faker::Date.between(from: 5.days.ago, to: Date.today),
        duration: 60,
        monday: true,
        tuesday: true,
        wednesday: true,
        thursday: true,
        friday: true,
        saturday: true,
        sunday: true,
        teacher: Teacher.sample,
        room: Room.sample,
        klass_template: KlassTemplate.sample,
        account: Account.sample
      )
    end
  end
end
