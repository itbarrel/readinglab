# frozen_string_literal: true

class Old::GameTemplateRole < Old::ApplicationRecord
  belongs_to :account
  belongs_to :template
end
