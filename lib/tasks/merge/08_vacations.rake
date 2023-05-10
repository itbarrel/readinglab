# frozen_string_literal: true

namespace :merge do
  desc 'Merges vacations to new tables'
  task vacations: :environment do
    Old::Vacation.all do |old_vacation|
      Vacation.find_or_create_by!(
        name: old_vacation.name,
        account_id: old_vacation.account_id,
        vacation_type_id: Vacation.where(name: Vacation.default_seeds).first
      ) do |vacation|
        vacation.id = old_vacation.id
        vacation.starting_at = old_vacation.day.beginning_of_day
        vacation.ending_at = old_vacation.day.end_of_day
        vacation.created_at = old_vacation.created_at
        vacation.updated_at = old_vacation.updated_at
        vacation.deleted_at = old_vacation.deleted_at
      end
    end
    puts 'Successfully Merged Vacations.'
  end
end
