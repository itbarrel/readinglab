# frozen_string_literal: true

module FormHelper
  def generate_html_for(field, student, submit_resource, data = nil)
    model_key = "#{submit_resource}[#{student.id}][#{field.model_key}]"

    if data.present?
      value = data.form_values[field.model_key]
    else
      value = nil
      data = { created_at: Time.zone.now }.to_dot
    end

    field_disabled = data.created_at < 2.weeks.ago && !(current_user.admin? || current_user.supervisor?)
    field.field_type = 'text_field' if field.field_type.nil?

    case field.field_type
    when 'text_field'
      text_field_tag model_key, value, class: 'form-control', required: field.necessary, disabled: field_disabled
    when 'number_field'
      number_field_tag model_key, value, class: 'form-control', required: field.necessary, disabled: field_disabled
    when 'date_field'
      date_field_tag model_key, value, class: 'form-control', required: field.necessary, disabled: field_disabled
    when 'date_time_field'
      datetime_field_tag model_key, value, class: 'form-control', required: field.necessary, disabled: field_disabled
    when 'text_area'
      text_area_tag model_key, value, class: 'form-control', required: field.necessary, disabled: field_disabled
    when 'select_field'
      select_tag model_key,
                 options_from_collection_for_select(field.field_values, :usage, :name, value),
                 class: 'form-control',
                 include_blank: true, required: field.necessary, disabled: field_disabled
    when 'check_box'
      html = []
      field.field_values.map do |fv|
        html << content_tag(:div, class: 'form-check form-check-inline') do
          (content_tag(:input, nil, type: 'checkbox', value: fv.usage, class: 'form-check-input', name: model_key, disabled: field_disabled) +
          content_tag(:label, fv.name, class: 'form-check-label'))
        end
      end
      safe_join(html)
    when 'radio_button'
      html = []
      field.field_values.map do |fv|
        html << content_tag(:div, class: 'form-check form-check-inline') do
          (content_tag(:input, nil, type: 'radio', value: fv.usage, class: 'form-check-input', name: model_key, disabled: field_disabled) +
          content_tag(:label, fv.name, class: 'form-check-label'))
        end
      end
      safe_join(html)
    else
      text_field_tag model_key, nil, class: 'form-control', required: field.necessary, disabled: field_disabled
    end
  end
end
