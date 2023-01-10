if Rails.env.development?
  5.times do
    StudentClass.find_or_create_by(
      account: Account.sample,
      klass: Klass.sample,
      student: Student.sample
    )
  end
end