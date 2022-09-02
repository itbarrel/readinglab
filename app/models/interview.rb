class Interview < ApplicationRecord
  belongs_to :account
  belongs_to :form
  belongs_to :student
  has_many :form_details,as: :parent
end
