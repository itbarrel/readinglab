class Student < ApplicationRecord
  belongs_to :account
  enum :status, [ :interviewed, :active, :wait_list ]

end
