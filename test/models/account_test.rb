# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id              :uuid             not null, primary key
#  address         :text
#  billing_scheme  :integer
#  country_code    :string
#  currency        :string
#  deleted_at      :datetime
#  email           :string
#  mobile          :string
#  name            :string
#  notify_emails   :boolean
#  postal_code     :integer
#  province        :string
#  settings        :jsonb
#  timezone        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_type_id :uuid             not null
#  parent_id       :uuid
#
# Indexes
#
#  accounts_name                      (name,deleted_at) UNIQUE
#  index_accounts_on_account_type_id  (account_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_type_id => account_types.id)
#
require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
