# frozen_string_literal: true

namespace :merge do
  desc 'Merges form_details to new tables'
  task form_details: :environment do
    parents = {}

    Parent.all.each do |x|
      parents[x.id] = true
    end

    Old::FormDetail.all.each do |old_form_detail|
      next unless parents[old_form_detail.form_detail_id]

      FormDetail.find_or_create_by!(
        account_id: old_form_detail.account_id,
        parent_id: old_form_detail.parent_id,
        form_id: old_form_detail.form_id,
      ) do |form_detail|
        form_detail.id = old_form_detail.id
        form_detail.form_values = old_form_detail.form_values
        form_detail.parent_type = old_form_detail.parent_type
        form_detail.created_at = old_form_detail.created_at
        form_detail.updated_at = old_form_detail.updated_at
        form_detail.deleted_at = old_form_detail.deleted_at
      end
    end
  end
end
