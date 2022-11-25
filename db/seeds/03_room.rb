# frozen_string_literal: true

5.times do
  Room.find_or_create_by!(
    name: Faker::Name.first_name,
    capacity: Faker::Number.number(digits: 2),
    color: Faker::Color.hex_color, #=> "#31a785"
    account: Account.sample,
  )
end


# Room.find_or_create_by!(name: 'room 1', capacity: 22, account: Account.last)
# Room.find_or_create_by!(name: 'room 2', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 3', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 4', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 5', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 6', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 7', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 8', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 9', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 10', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 11', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 12', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 13', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 14', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 15', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 16', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 17', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 18', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 19', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 20', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 21', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 22', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 23', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 24', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 25', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 26', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 27', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 28', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 29', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 30', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 31', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 32', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 33', capacity: 24, color: 'black', account: Account.last)
# Room.find_or_create_by!(name: 'room 34', capacity: 24, color: 'black', account: Account.last)

