# frozen_string_literal: true

class Old::ReceiptType < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  has_one :receipt, class_name: 'Old::Receipt'

  acts_as_paranoid
  scope :active, -> { where(active: true) }
  def created
    created_at
  end
end
