# frozen_string_literal: true

# == Schema Information
#
# Table name: forms
#
#  id            :uuid             not null, primary key
#  attendancable :boolean          default(FALSE)
#  deleted_at    :datetime
#  fields        :jsonb
#  lessonable    :boolean          default(FALSE)
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :uuid             not null
#
# Indexes
#
#  forms_name                 (account_id,name,deleted_at) UNIQUE
#  index_forms_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require 'test_helper'

class FormTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
