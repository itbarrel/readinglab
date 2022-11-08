# frozen_string_literal: true

# == Schema Information
#
# Table name: parents
#
#  id           :uuid             not null, primary key
#  address      :text
#  deleted_at   :datetime
#  father_email :string
#  father_first :string
#  father_last  :string
#  father_phone :string
#  mother_email :string
#  mother_first :string
#  mother_last  :string
#  mother_phone :string
#  postal_code  :string
#  state        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :uuid             not null
#  city_id      :uuid             not null
#
# Indexes
#
#  index_parents_on_account_id  (account_id)
#  index_parents_on_city_id     (city_id)
#  parents_name                 (account_id,father_email,mother_email,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (city_id => cities.id)
#
require 'test_helper'

class ParentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
