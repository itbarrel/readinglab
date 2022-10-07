# frozen_string_literal: true

user = User.find_or_create_by!(account_id: Account.last.id, role: :teacher, email: 'teacher@readinglab.co',
                               first_name: 'Teacher', last_name: 'Heavy') do |user|
  user.password = '12345678'
end
