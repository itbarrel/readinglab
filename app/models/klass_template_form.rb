# frozen_string_literal: true

# == Schema Information
#
# Table name: klass_template_forms
#
#  id                :uuid             not null, primary key
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  form_id           :uuid             not null
#  klass_template_id :uuid             not null
#
# Indexes
#
#  index_klass_template_forms_on_form_id            (form_id)
#  index_klass_template_forms_on_klass_template_id  (klass_template_id)
#  klass_template_forms_id                          (klass_template_id,form_id,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (form_id => forms.id)
#  fk_rails_...  (klass_template_id => klass_templates.id)
#
class KlassTemplateForm < ApplicationRecord
  belongs_to :klass_template
  belongs_to :form
end
