# frozen_string_literal: true

if ENV.fetch("SEED_DATABASE").present? && true?(ENV.fetch("SEED_DATABASE"))
  if Rails.env.development?
    StudentClass.find_or_create_by(
      klass: Klass.sample,
      student: Student.sample
    )
  end
end
