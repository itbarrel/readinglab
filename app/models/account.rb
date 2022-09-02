class Account < ApplicationRecord
  belongs_to :account_type
  has_many :vacations
  has_many :vacation_types
  has_many :users
  has_many :rooms
  has_many :forms
  has_many :students
  has_many :interviews

end
