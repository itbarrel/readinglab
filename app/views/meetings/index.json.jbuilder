# frozen_string_literal: true

json.array! @meetings do |meeting|
  json.id meeting.id
  json.start meeting.starts_at.to_date
  json.end meeting.ends_at.to_date
  json.title meeting.klass.name
end
