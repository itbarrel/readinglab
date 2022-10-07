# frozen_string_literal: true

# == Schema Information
#
# Table name: form_details
#
#  id          :uuid             not null, primary key
#  deleted_at  :datetime
#  form_values :jsonb
#  parent_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :uuid             not null
#  form_id     :uuid             not null
#  parent_id   :uuid             not null
#  user_id     :uuid             not null
#
# Indexes
#
#  index_form_details_on_account_id  (account_id)
#  index_form_details_on_form_id     (form_id)
#  index_form_details_on_parent      (parent_type,parent_id)
#  index_form_details_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (form_id => forms.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class FormDetailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
