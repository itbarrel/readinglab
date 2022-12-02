# frozen_string_literal: true

json.array! @meetings do |meeting|
  json.id meeting.id
  json.start meeting.starts_at
  json.end meeting.ends_at
  json.title meeting.klass.name
  json.className 'bg-soft-primary'
end
