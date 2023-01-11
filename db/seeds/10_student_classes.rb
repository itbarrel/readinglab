if Rails.env.development?
  5.times do
    StudentClass.find_or_create_by(
      klass: Klass.sample,
      student: Student.sample
    )
  end
end