class Meeting < ApplicationRecord
  belongs_to :account
  belongs_to :klass
  belongs_to :form
end
