class Meetingstudent < ApplicationRecord
  belongs_to :account
  belongs_to :meeting
  belongs_to :student
end
