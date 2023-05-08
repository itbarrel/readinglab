# frozen_string_literal: true

namespace :merge do
  desc 'Merges students to new tables'
  task students: :environment do
    Old::Student.where(first: nil).delete_all

    deleted_parents = Old::Student.all.map(&:parent_id) - Parent.ids

    duplicates = Old::Student.select(:first, :last, :parent_id, :account_id, :school)
                             .group(:first, :last, :parent_id, :account_id, :school)
                             .having('count(*) > 1')

    duplicates.each do |x|
      x.update(first: "#{x.first}.")
    end

    gender_mapping = {
      'M': 'male',
      'F': 'female',
      'O': 'others'
    }

    Old::Student.where.not(parent_id: deleted_parents).find_each(batch_size: 100) do |old_student|
      Student.find_or_create_by!(
        first_name: old_student.first,
        last_name: old_student.last,
        account_id: old_student.account_id,
        school: old_student.school,
        parent_id: old_student.parent_id
      ) do |student|
        student.id = old_student.id
        student.dob = old_student.dob
        student.grade = old_student.grade
        student.settings = old_student.settings
        student.status = old_student.status
        student.prepaid_sessions = old_student.prepaid_sessions
        student.registration_date = old_student.registration_date
        student.dates = old_student.dates
        student.gender = gender_mapping[old_student.sex.to_sym]
        student.credit_session = old_student.credit_session
        student.created_at = old_student.created_at
        student.updated_at = old_student.updated_at
        student.deleted_at = old_student.deleted_at
      end
    end
    puts 'Successfully Merged Students.'
  end
end
# Student.find_or_create_by!(first_name: old_student.first,
# last_name: old_student.last,account_id: old_student.account_id,
# school: old_student.school.presence || 'Readinglab',parent_id: old_student.parent_id)

# Old::Student.where(first: 'Aleena').select(:first, :last, :parent_id, :account_id,
#  :school).group(:first, :last, :parent_id, :account_id, :school).having('count(*) > 1')
