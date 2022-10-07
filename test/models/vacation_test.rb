# frozen_string_literal: true

# == Schema Information
#
# Table name: vacations
#
#  id               :uuid             not null, primary key
#  deleted_at       :datetime
#  ending_at        :datetime
#  name             :string
#  starting_at      :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  account_id       :uuid             not null
#  vacation_type_id :uuid             not null
#
# Indexes
#
#  index_vacations_on_account_id        (account_id)
#  index_vacations_on_vacation_type_id  (vacation_type_id)
#  vacations_name                       (account_id,name,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (vacation_type_id => vacation_types.id)
#
require 'test_helper'

class VacationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
