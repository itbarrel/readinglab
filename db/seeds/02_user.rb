# frozen_string_literal: true


5.times do
  User.find_or_create_by!(
    first_name: Faker::Name.first_name ,
    last_name: Faker::Name.last_name ,
    email: Faker::Internet.email,
    account: Account.sample,
    role: User.roles.keys.sample
  ) do |user|
    user.password = '12345678'
  end

end


# user = User.find_or_create_by!(account_id: Account.last.id, role: :super_admin, email: 'super_admin@readinglab.co',
#                                first_name: 'Super', last_name: 'Admin') do |user|
#   user.password = '12345678'
# end

# user = User.where(email: 'super_admin@readinglab.co').first_or_initialize
# user.update(account_id: '00000000-0000-0000-0000-000000000000', role: 'super_admin',first_name: 'Super',last_name: 'Admin',password: 'reading123')

# user = User.where(email: 'support@readinglab.co').first_or_initialize
# user.update(account_id: '00000000-0000-0000-0000-000000009600', role: 'admin',first_name: 'Senior',last_name: 'Admin',password: 'reading123')

# user = User.where(email: 'admin_junior@readinglab.co').first_or_initialize
# user.update(account_id: '00000000-0000-0000-0000-000000009600', role: 'admin_junior',first_name: 'Junior',last_name: 'Admin',password: 'reading123')

# user = User.where(email: 'supervisor@readinglab.co').first_or_initialize
# user.update(account_id: '00000000-0000-0000-0000-000000009600', role: 'supervisor',first_name: 'Super',last_name: 'Visor',password: 'reading123')

# user = User.where(email: 'teacher@readinglab.co').first_or_initialize
# user.update(account_id: '00000000-0000-0000-0000-000000009600', role: 'admin',first_name: 'Test',last_name: 'Teacher',password: 'reading123')
