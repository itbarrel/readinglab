class TrajectoryDetail < ApplicationRecord
  belongs_to :account
  belongs_to :student
  belongs_to :klass
  belongs_to :book
  enum :status, [ :draft, :published, :archived ]
end
