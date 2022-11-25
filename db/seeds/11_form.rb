5.times do
Form.find_or_create_by(
  name: Faker::Name.first_name , 
  account: Account.sample,
)
end