# frozen_string_literal: true

class Old::MessageControl < Old::ApplicationRecord
  belongs_to :account
  belongs_to :game_instance
  belongs_to :message
end
