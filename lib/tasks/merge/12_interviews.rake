# frozen_string_literal: true

namespace :merge do
  desc 'Merges interviews to new tables'
  task interviews: :environment do
    Old::Interview.all.each do |old_interview|
      Interview.find_or_create_by!(
        account_id: old_interview.account_id,
        student_id: old_interview.student_id,
        form_id: old_interview.form_id
      ) do |interview|
        interview.id = old_interview.id
        interview.date = old_interview.date
        interview.status = old_interview.status.to_i
        interview.feedback = old_interview.feedback
        interview.created_at = old_interview.created_at
        interview.updated_at = old_interview.updated_at
        interview.deleted_at = old_interview.deleted_at
      end
    rescue StandardError
      1 + 1
    end
  end
end
# Interview.find_or_create_by!(account_id: old_interview.account_id,
# student_id: old_interview.student_id,form_id: old_interview.form_id)
