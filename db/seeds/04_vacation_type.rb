if Rails.env.development?
5.times do
    VacationType.find_or_create_by(
      name: Faker::Name.first_name,
      description: 'eid_holiday',
      account: Account.sample,
    )
  end
end