# frozen_string_literal: true

# == Schema Information
#
# Table name: class_fee_rates
#
#  id         :uuid             not null, primary key
#  amount     :decimal(19, 4)
#  sessions   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  account_id :uuid             not null
#  r_class_id :uuid             not null
#
# Indexes
#
#  index_class_fee_rates_on_account_id  (account_id)
#  index_class_fee_rates_on_r_class_id  (r_class_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (r_class_id => r_classes.id)
#
class Old::ClassFeeRate < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :r_class, class_name: 'Old::RClass'
end
