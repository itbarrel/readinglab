# frozen_string_literal: true

json.array! @interview_students do |student|
  interview = student.latest_interview
  json.id interview.id
  json.start interview.date
  json.end interview.date + 1.hour
  json.title interview.student.name
  json.className 'bg-soft-primary'
end
