# frozen_string_literal: true

# == Schema Information
#
# Table name: field_values
#
#  id            :uuid             not null, primary key
#  deleted_at    :datetime
#  name          :string
#  usage         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  form_field_id :uuid             not null
#
# Indexes
#
#  index_field_values_on_form_field_id  (form_field_id)
#
# Foreign Keys
#
#  fk_rails_...  (form_field_id => form_fields.id)
#
class FieldValue < ApplicationRecord
  belongs_to :form_field
end
