# frozen_string_literal: true

namespace :merge do
  desc 'Merges parents to new tables'
  task parents: :environment do
    Old::Parent.all.find_each do |old_parent|
      Parent.find_or_create_by!(
        father_first: old_parent.father_first,
        father_last: old_parent.father_last.presence || 'Father',
        father_phone: old_parent.father_cell.presence || '03xxxxxxxxx',
        father_email: old_parent.father_email,
        mother_first: old_parent.mother_first.presence || 'Mrs.',
        mother_last: old_parent.mother_last.presence || 'Mother',
        mother_phone: old_parent.mother_cell.presence || '03xxxxxxxxx',
        mother_email: old_parent.mother_email,
        account_id: old_parent.account_id,
        postal_code: old_parent.postal_code.presence || 54_000,
        address: old_parent.address.presence || 'Karachi',
        city: City.where(name: City.default_seeds).last
      ) do |parent|
        parent.id = old_parent.id
        parent.state = old_parent.state
        parent.created_at = old_parent.created_at
        parent.updated_at = old_parent.updated_at
        parent.deleted_at = old_parent.deleted_at
      end
    end
    puts 'Successfully Merged Parents.'
  end
end
