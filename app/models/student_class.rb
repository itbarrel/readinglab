class StudentClass < ApplicationRecord
  belongs_to :account
  belongs_to :student
  belongs_to :klass
end
