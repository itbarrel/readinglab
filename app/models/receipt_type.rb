class ReceiptType < ApplicationRecord
  belongs_to :account
  enum :status, [ :tution_fee, :addmission_fee, :sports_fee ]

end
