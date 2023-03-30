# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id                   :uuid             not null, primary key
#  active               :boolean          default(TRUE)
#  address              :text
#  billing_scheme       :string
#  country_code         :string
#  currency             :string
#  default_meeting_form :uuid
#  default_student_form :uuid
#  deleted_at           :datetime
#  email                :string
#  mobile               :string
#  name                 :string
#  postal_code          :integer
#  province             :string
#  send_emails          :boolean          default(TRUE)
#  settings             :jsonb
#  timezone             :string
#  created_at           :datetime
#  updated_at           :datetime
#  parent_id            :uuid
#  user_id              :uuid
#
# Indexes
#
#  index_accounts_on_parent_id  (parent_id)
#  index_accounts_on_user_id    (user_id)
#
class Old::Account < Old::ApplicationRecord
  has_many :students, class_name: 'Old::Student'
  has_many :users, class_name: 'Old::User'
  has_many :student_class_histories, class_name: 'Old::StudentClassHistory'

  has_and_belongs_to_many :account_types, class_name: 'Old::AccountType'

  # has_many :class_templates
  scope :active, -> { where(active: true) }
end
