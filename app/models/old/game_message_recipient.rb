# frozen_string_literal: true

class Old::GameMessageRecipient < Old::ApplicationRecord
  belongs_to :account
  belongs_to :message
  belongs_to :role
end
