# frozen_string_literal: true

Vacation.find_each do |x|
  x.destroy
end
5.times do
  Vacation.find_or_create_by(
  name: Faker::Name.name,
  starting_at: Date.today + 1.day,
  ending_at:   Date.today + 3.days,
  account: Account.sample,
  vacation_type: VacationType.sample,
)
end
