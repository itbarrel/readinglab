# frozen_string_literal: true

class Old::GameTemplateMessage < Old::ApplicationRecord
  belongs_to :account
  belongs_to :template
  has_many :recipients
end
