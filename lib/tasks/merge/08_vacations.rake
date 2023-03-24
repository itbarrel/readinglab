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
        vacation.starting_at = '2023-02-20 17:12:04 PKT'
        vacation.ending_at = '2023-02-20 18:12:04 PKT'
        vacation.created_at = old_vacation.created_at
        vacation.updated_at = old_vacation.updated_at
        vacation.deleted_at = old_vacation.deleted_at
      end
    end
  end
end
