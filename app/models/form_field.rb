# frozen_string_literal: true

# == Schema Information
#
# Table name: form_fields
#
#  id          :uuid             not null, primary key
#  data_type   :string
#  deleted_at  :datetime
#  description :string
#  field_type  :integer
#  model_key   :string
#  name        :string
#  necessary   :boolean
#  sort_order  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  form_id     :uuid             not null
#
# Indexes
#
#  index_form_fields_on_form_id  (form_id)
#
# Foreign Keys
#
#  fk_rails_...  (form_id => forms.id)
#
class FormField < ApplicationRecord
  belongs_to :form
  has_many :field_values, dependent: :destroy

  enum :field_type, %i[text_field number_field text_area select_field check_box radio_button]

  accepts_nested_attributes_for :field_values, allow_destroy: true, reject_if: :all_blank

  before_save :default_type

  def default_type
    self.model_key ||= (0...8).map { rand(97..122).chr }.join
  end
end
