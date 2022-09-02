class Klass < ApplicationRecord
  belongs_to :account
  belongs_to :user
  belongs_to :room
  belongs_to :klass_template

end
