# frozen_string_literal: true

# == Schema Information
#
# Table name: approved_vacations
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  end_date   :datetime
#  reason     :string
#  start_date :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#  student_id :uuid             not null
#
# Indexes
#
#  index_approved_vacations_on_account_id  (account_id)
#  index_approved_vacations_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (student_id => students.id)
#
class ApprovedVacation < ApplicationRecord
  belongs_to :student
  belongs_to :account
end
