# frozen_string_literal: true

class Old::RoleAssignment < Old::ApplicationRecord
  belongs_to :account
  belongs_to :instance
  belongs_to :role
  belongs_to :student
end
