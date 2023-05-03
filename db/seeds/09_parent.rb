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
if Rails.env.development? && ENV['SEEDS_OFF']
  5.times do
    Parent.find_or_create_by!(
      father_first: Faker::Name.first_name,
      father_last: Faker::Name.last_name,
      mother_first: Faker::Name.first_name,
      mother_last: Faker::Name.last_name,
      father_email: Faker::Internet.email,
      mother_email: Faker::Internet.email,
      father_phone: Faker::PhoneNumber.cell_phone,
      mother_phone: Faker::PhoneNumber.cell_phone,
      postal_code: Faker::Address.zip_code,
      address: Faker::Address.full_address,
      account: Account.sample,
      city: City.sample
    ) 
  end
end
