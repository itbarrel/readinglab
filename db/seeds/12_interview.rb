Interview.find_or_create_by(
  date: Date.yesterday, 
  status: 'waiting',
  account: Account.last,
  student: Student.last,
  form: Form.last,

)