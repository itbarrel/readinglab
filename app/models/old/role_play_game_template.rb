# frozen_string_literal: true

class Old::RolePlayGameTemplate < Old::ApplicationRecord
  belongs_to :account
  has_many :content, through: :game_template_content
  has_many :game_template_messages
  has_many :game_template_roles
  has_many :game_instances
end
