# frozen_string_literal: true

# == Schema Information
#
# Table name: billing_notices
#
#  id         :uuid             not null, primary key
#  reason     :string
#  sent_to    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid
#  r_class_id :uuid
#  student_id :uuid
#
# Indexes
#
#  index_billing_notices_on_account_id  (account_id)
#  index_billing_notices_on_r_class_id  (r_class_id)
#  index_billing_notices_on_student_id  (student_id)
#
class Old::BillingNotice < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :r_class, class_name: 'Old::RClass'
  belongs_to :student, class_name: 'Old::student'
end
