# frozen_string_literal: true

module FormHelper
  def generate_html_for(field, student)
    model_key = "form_details[#{student.id}][#{field.model_key}]"
    case field.field_type
    when 'text_field'
      text_field_tag model_key, nil, class: 'form-control'
    when 'number_field'
      number_field_tag model_key, nil, class: 'form-control'
    when 'text_area'
      text_area_tag model_key, nil, class: 'form-control'
    when 'select_field'
      select_tag model_key,
                 options_from_collection_for_select(field.field_values, :usage, :name),
                 class: 'form-control',
                 include_blank: true
    when 'check_box'
      html = []
      field.field_values.map do |fv|
        html << content_tag(:div, class: "form-check form-check-inline") do
          (content_tag(:input, nil, type: 'checkbox', value: fv.usage, class: "form-check-input", name: model_key) +
          content_tag(:label, fv.name, class: "form-check-label"))
        end
      end
      safe_join(html)
    when 'radio_button'
      html = []
      field.field_values.map do |fv|
        html << content_tag(:div, class: "form-check form-check-inline") do
          (content_tag(:input, nil, type: 'radio', value: fv.usage, class: "form-check-input", name: model_key) +
          content_tag(:label, fv.name, class: "form-check-label"))
        end
      end
      safe_join(html)
    else
      text_field_tag model_key, nil, class: 'form-control'
    end
  end
end
