# frozen_string_literal: true

# == Schema Information
#
# Table name: game_template_messages
#
#  id          :uuid             not null, primary key
#  delay       :integer
#  message     :string
#  created_at  :datetime
#  updated_at  :datetime
#  account_id  :uuid             not null
#  content_id  :uuid
#  template_id :uuid             not null
#
# Indexes
#
#  index_game_template_messages_on_account_id   (account_id)
#  index_game_template_messages_on_content_id   (content_id)
#  index_game_template_messages_on_template_id  (template_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (content_id => content.id)
#  fk_rails_...  (template_id => role_play_game_templates.id) ON DELETE => cascade
#
class Old::GameTemplateMessage < Old::ApplicationRecord
  belongs_to :account
  belongs_to :template
  has_many :recipients
end
