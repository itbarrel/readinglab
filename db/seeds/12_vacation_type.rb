VacationType.find_or_create_by(
  name: 'nsd',
  description: 'eid_holiday',
  account: Account.last,
)