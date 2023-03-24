# frozen_string_literal: true

class Old::Reason < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :vacation, class_name: 'Old::Vacation'
  acts_as_paranoid
  scope :active, -> { where(active: true) }
  # parent, :polymorphic => true
end
