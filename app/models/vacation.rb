class Vacation < ApplicationRecord
    
    belongs_to :account
    belongs_to :vacation_type
end
