# frozen_string_literal: true

namespace :merge do
  desc 'Merges forms to new tables'
  task forms: :environment do
    field_types = {
      'select': 'select_field',
      'text_field': 'text_field',
      'number_field': 'number_field',
      'text_area': 'text_area',
      'checkbox': 'check_box',
      'radio_button': 'radio_button'
    }
    data_types = {
      'select': 'string',
      'text_field': 'string',
      'number_field': 'integer',
      'text_area': 'string',
      'checkbox': 'string',
      'radio_button': 'string'
    }
    Old::Form.all.each do |old_form|
      Form.find_or_create_by!(
        name: old_form.name,
        account_id: old_form.account_id
      ) do |form|
        form.id = old_form.id
        form.purpose = 'general'
        form.purpose = 'lessonable' if old_form.for_lesson == true
        form.purpose = 'attendancable' if old_form.attendance_form == true

        form.created_at = old_form.created_at
        form.updated_at = old_form.updated_at
        form.save

        next if old_form.fields['fields'].nil?

        old_form.fields['fields'].each_with_index do |old_field, index|
          FormField.find_or_create_by!(
            name: old_field['name'],
            model_key: old_field['model'],
            form_id: form.id
          ) do |field|
            field.sort_order = index
            field.necessary = old_field['required']
            field.field_type = field_types[old_field['type'].to_sym]
            field.data_type = data_types[old_field['type'].to_sym]
            field.description = old_field['title']
            field.save
            next if old_field['values'].nil?

            old_field['values'].each_with_index do |old_field_value, _index|
              FieldValue.find_or_create_by!(
                name: old_field_value['label'],
                form_field_id: field.id
              ) do |field_value|
                field_value.usage = old_field_value['value']
              end
            end
          end
        end
      end
    end
    puts 'Successfully Merged Forms.'
  end
end
