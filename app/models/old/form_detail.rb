# frozen_string_literal: true

# == Schema Information
#
# Table name: form_details
#
#  id          :uuid             not null, primary key
#  active      :boolean          default(TRUE)
#  deleted_at  :datetime
#  form_values :jsonb
#  parent_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :uuid
#  form_id     :uuid
#  parent_id   :uuid
#
# Indexes
#
#  index_form_details_on_account_id  (account_id)
#  index_form_details_on_form_id     (form_id)
#  index_form_details_on_parent_id   (parent_id)
#
class Old::FormDetail < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :parent, polymorphic: true, class_name: 'Old::Parent'
  # belongs_to :interview
  belongs_to :form, class_name: 'Old::Form'
  scope :active, -> { where(active: true) }
  acts_as_paranoid

  store_accessor :form_values, :student
end
