# frozen_string_literal: true

class Old::LibraryMessage < Old::ApplicationRecord
  belongs_to :account
  scope :active, -> { where(active: true) }
  acts_as_paranoid
end
