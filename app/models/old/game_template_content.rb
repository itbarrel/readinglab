# frozen_string_literal: true

class Old::GameTemplateContent < Old::ApplicationRecord
  self.table_name = 'game_template_content'
  belongs_to :account
  belongs_to :template
  belongs_to :content
end
