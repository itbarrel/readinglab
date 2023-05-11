# frozen_string_literal: true

namespace :merge do
  desc 'Merges rooms to new tables'
  task rooms: :environment do
    Old::Room.all.each do |old_room|
      Room.find_or_create_by!(
        name: old_room.name,
        account_id: old_room.account_id
      ) do |room|
        room.id = old_room.id
        room.capacity = old_room.capacity
        room.color = old_room.color
        room.created_at = old_room.created_at
        room.updated_at = old_room.updated_at
        room.deleted_at = old_room.active ? old_room.deleted_at : old_room.updated_at
      end
    end
    puts 'Successfully Merged Rooms.'
  end
end
