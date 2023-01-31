# frozen_string_literal: true

# == Schema Information
#
# Table name: message_templates
#
#  id          :uuid             not null, primary key
#  deleted_at  :datetime
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :uuid             not null
#
# Indexes
#
#  index_message_templates_on_account_id  (account_id)
#  message_template_index                 (name,account_id,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class MessageTemplate < ApplicationRecord
  belongs_to :account

  validates :name, presence: true, uniqueness: { scope: %i[account_id name deleted_at] }
  validates :description, presence: true
end
