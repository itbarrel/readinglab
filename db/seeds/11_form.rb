if Rails.env.development? && ENV['SEEDS_OFF']
  5.times do
    Form.find_or_create_by(
      name: Faker::Name.first_name, 
      account: Account.sample,
    )
  end
end