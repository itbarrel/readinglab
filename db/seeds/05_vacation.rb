# frozen_string_literal: true

Vacation.find_each do |x|
  x.destroy
end

Vacation.find_or_create_by(
  name: 'mashal',
  starting_at: Date.today + 1.day,
  ending_at:   Date.today + 3.days,
  account: Account.last,
  vacation_type: VacationType.last,

)