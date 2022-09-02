class Receipt < ApplicationRecord
  belongs_to :account
  belongs_to :student
  belongs_to :receipt_type

end
