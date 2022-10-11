# frozen_string_literal: true

Student.find_or_create_by(
  first_name: 'mashal',
  last_name: 'zareen',
  school: 'saadschoolsystem',
  account: Account.last,
  parent: Parent.last
)
