# frozen_string_literal: true

class Old::Vacation < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :reason, class_name: 'Old::Reason'
  acts_as_paranoid
  scope :active, -> { where(active: true) }
  # , as: :parent
end
