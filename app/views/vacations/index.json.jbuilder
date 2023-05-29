# frozen_string_literal: true

json.array! @vacations do |vacation|
  json.id vacation.id
  json.title vacation.name
  json.start vacation.starting_at
  json.end vacation.ending_at
  json.type 'Vacation'
end
