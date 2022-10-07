# frozen_string_literal: true

Parent.find_or_create_by(
  father_first: 'sun',
  father_last: 'shine',
  mother_first: 'moon',
  mother_last: 'light',
  father_email: 'sunshine@gmail.com',
  mother_email: 'moonlight@gmail.com',
  father_phone: '33333',
  mother_phone: '44444',
  address: 'jail,road',
  postal_code: '234',
  account: Account.last,
  city: City.last
)
