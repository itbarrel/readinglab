class Book < ApplicationRecord
  belongs_to :account
  belongs_to :klass
end
