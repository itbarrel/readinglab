# frozen_string_literal: true

class Old::Salary < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :user, class_name: 'Old::User'
end
