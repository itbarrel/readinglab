# frozen_string_literal: true

# == Schema Information
#
# Table name: message_controls
#
#  id             :uuid             not null, primary key
#  command        :string
#  delay_override :string
#  created_at     :datetime
#  updated_at     :datetime
#  account_id     :uuid             not null
#  instance_id    :uuid             not null
#  message_id     :uuid             not null
#
# Indexes
#
#  index_message_controls_on_account_id                  (account_id)
#  index_message_controls_on_instance_id                 (instance_id)
#  index_message_controls_on_instance_id_and_message_id  (instance_id,message_id) UNIQUE
#  index_message_controls_on_message_id                  (message_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (instance_id => game_instances.id) ON DELETE => cascade
#  fk_rails_...  (message_id => game_template_messages.id) ON DELETE => cascade
#
class Old::MessageControl < Old::ApplicationRecord
  belongs_to :account
  belongs_to :game_instance
  belongs_to :message
end
