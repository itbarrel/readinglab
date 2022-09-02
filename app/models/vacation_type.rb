 class VacationType < ApplicationRecord
    belongs_to :account
    has_many :vacations
end
