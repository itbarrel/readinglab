# frozen_string_literal: true

namespace :merge do
  desc 'Merges meetings to new tables'
  task meetings: :environment do
    klasses = {}

    Klass.all.each do |x|
      klasses[x.id] = true
    end

    Old::Meeting.find_each(batch_size: 200) do |old_meeting|
      next unless klasses[old_meeting.r_class_id]

      Meeting.find_or_create_by!(
        account_id: old_meeting.account_id,
        klass_id: old_meeting.r_class_id,
        starts_at: old_meeting.start
      ) do |meeting|
        meeting.id = old_meeting.id
        meeting.cancel = old_meeting.cancel
        meeting.created_at = old_meeting.created_at
        meeting.updated_at = old_meeting.updated_at
        meeting.deleted_at = old_meeting.deleted_at
      end
    end
    puts 'Successfully Merged Meetings.'
  end
end
