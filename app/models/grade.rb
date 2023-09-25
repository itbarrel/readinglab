# frozen_string_literal: true

# == Schema Information
#
# Table name: grades
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#
# Indexes
#
#  index_grades_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Grade < ApplicationRecord
  belongs_to :account
  has_many :books, dependent: nil
end
