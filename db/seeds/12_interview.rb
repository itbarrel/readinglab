# frozen_string_literal: true

if ENV.fetch("SEED_DATABASE").present? && true?(ENV.fetch("SEED_DATABASE"))
  if Rails.env.development?
    5.times do
      Interview.find_or_create_by(
        date: Faker::Date.between(from: 5.days.ago, to: Date.today),
        status: Interview.statuses.keys.sample,
        account: Account.sample,
        student: Student.sample,
        form: Form.sample
      )
    end
  end
end
