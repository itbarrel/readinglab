# frozen_string_literal: true

# == Schema Information
#
# Table name: game_message_recipients
#
#  id         :uuid             not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  account_id :uuid             not null
#  message_id :uuid             not null
#  role_id    :uuid             not null
#
# Indexes
#
#  index_game_message_recipients_on_account_id              (account_id)
#  index_game_message_recipients_on_message_id              (message_id)
#  index_game_message_recipients_on_message_id_and_role_id  (message_id,role_id) UNIQUE
#  index_game_message_recipients_on_role_id                 (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (message_id => game_template_messages.id) ON DELETE => cascade
#  fk_rails_...  (role_id => game_template_roles.id) ON DELETE => cascade
#
class Old::GameMessageRecipient < Old::ApplicationRecord
  belongs_to :account
  belongs_to :message
  belongs_to :role
end
