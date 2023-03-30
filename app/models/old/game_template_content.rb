# frozen_string_literal: true

# == Schema Information
#
# Table name: game_template_content
#
#  id          :uuid             not null, primary key
#  account_id  :uuid             not null
#  content_id  :uuid             not null
#  template_id :uuid             not null
#
# Indexes
#
#  index_game_template_content_on_account_id                  (account_id)
#  index_game_template_content_on_content_id                  (content_id)
#  index_game_template_content_on_template_id                 (template_id)
#  index_game_template_content_on_template_id_and_content_id  (template_id,content_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (content_id => content.id) ON DELETE => cascade
#  fk_rails_...  (template_id => role_play_game_templates.id) ON DELETE => cascade
#
class Old::GameTemplateContent < Old::ApplicationRecord
  self.table_name = 'game_template_content'
  belongs_to :account
  belongs_to :template
  belongs_to :content
end
