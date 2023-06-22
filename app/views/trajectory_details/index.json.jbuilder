# frozen_string_literal: true

json.trajectory_details @trajectory_details do |td|
  json.id td.id
  json.error_count td.error_count
  json.wpm td.wpm
  json.grade td.grade
  json.season td.season
  json.entry_date td.entry_date
  json.status td.status
  json.student_id td.student_id
  json.klass_id td.klass_id
  json.book_id td.book_id
end

json.seasons TrajectoryDetail.seasons
json.grades TrajectoryDetail.grades
