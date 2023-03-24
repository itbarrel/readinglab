# frozen_string_literal: true

# == Schema Information
#
# Table name: class_template_forms
#
#  class_template_id :uuid
#  form_id           :uuid
#
# Indexes
#
#  index_class_template_forms_on_class_template_id  (class_template_id)
#  index_class_template_forms_on_form_id            (form_id)
#
class Old::ClassTemplateForm < Old::ApplicationRecord
  belongs_to :class_template, class_name: 'Old::ClassTemplate'
  belongs_to :form, class_name: 'Old::Form'
end
