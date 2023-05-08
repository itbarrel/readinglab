# frozen_string_literal: true

namespace :merge do
  desc 'Merges form_details to new tables'
  task form_details: :environment do
    meetings = {}

    Meeting.all.each do |x|
      meetings[x.id] = true
    end

    interviews = {}

    Interview.all.each do |x|
      interviews[x.id] = true
    end

    students = {}

    Student.all.each do |x|
      students[x.id] = true
    end

    Old::FormDetail.find_each(batch_size: 100) do |old_form_detail|
      unless meetings[old_form_detail.parent_id] &&
             old_form_detail.parent_type == 'Meeting' ||
             interviews[old_form_detail.parent_id] &&
             old_form_detail.parent_type == 'Interview'
        next
      end

      next if old_form_detail.form_values['student'].blank?

      old_form_detail.form_values['student'].each do |student_id, old_form_data|
        next if students[student_id].blank?

        FormDetail.find_or_create_by!(
          account_id: old_form_detail.account_id,
          parent_id: old_form_detail.parent_id,
          form_id: old_form_detail.form_id,
          student_id:
        ) do |form_detail|
          form_detail.form_values = old_form_data
          form_detail.parent_type = old_form_detail.parent_type
          form_detail.created_at = old_form_detail.created_at
          form_detail.updated_at = old_form_detail.updated_at
          form_detail.deleted_at = old_form_detail.deleted_at
        end
      end
    end
    puts 'Successfully Merged Form Details.'
  end
end
