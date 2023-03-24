# frozen_string_literal: true

namespace :merge do
  desc 'Merges forms to new tables'
  task forms: :environment do
    Old::Form.all.each_with_index do |old_form, index|
      Form.find_or_create_by!(
        name: old_form.name || "Form_#{index}",
        account_id: old_form.account_id
      ) do |form|
        form.id = old_form.id
        form.fields = old_form.fields
        form.created_at = old_form.created_at
        form.updated_at = old_form.updated_at
      end
    end
  end
end
