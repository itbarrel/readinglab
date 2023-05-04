# frozen_string_literal: true
if ENV.fetch("SEED_DATABASE").present? && true?(ENV.fetch("SEED_DATABASE"))
  if Rails.env.development?
    5.times do
      Vacation.find_or_create_by(
        name: Faker::Name.name,
        starting_at: Date.today + 1.day,
        ending_at:   Date.today + 3.days,
        account: Account.sample,
        vacation_type: VacationType.sample,
      )
    end
  end
end
