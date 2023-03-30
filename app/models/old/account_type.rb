# frozen_string_literal: true

# == Schema Information
#
# Table name: account_types
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#
class Old::AccountType < Old::ApplicationRecord
  has_and_belongs_to_many :accounts, class_name: 'Old::Account'
end
