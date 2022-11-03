# frozen_string_literal: true

# == Schema Information
#
# Table name: vacation_types
#
#  id          :uuid             not null, primary key
#  deleted_at  :datetime
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :uuid             not null
#
# Indexes
#
#  index_vacation_types_on_account_id  (account_id)
#  vacation_types_name                 (account_id,name,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class VacationType < ApplicationRecord
  belongs_to :account
  has_many :vacations, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: %i[account_id name deleted_at] }
end
