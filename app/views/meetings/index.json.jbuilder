# frozen_string_literal: true

json.array! @meetings do |meeting|
  json.id meeting.id
  json.start zone_date(meeting.starts_at).to_date
  json.end zone_date(meeting.ends_at).to_date
  json.title meeting.klass.calendar_name
  json.type 'Meeting'
  json.percentage ((meeting.students.length.to_f / meeting.klass.max_students) * 100).to_f
end
