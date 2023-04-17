# frozen_string_literal: true

if Rails.env.development? && ENV['SEEDS_OFF']
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
