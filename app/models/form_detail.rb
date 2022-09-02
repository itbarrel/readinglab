class FormDetail < ApplicationRecord
  belongs_to :user
  belongs_to :form
  belongs_to :account
  belongs_to :parent, polymorphic: true

end
