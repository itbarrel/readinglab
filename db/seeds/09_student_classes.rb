StudentClass.find_or_create_by(
  account: Account.last,
  klass: Klass.last,
  student: Student.last
)