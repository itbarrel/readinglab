# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id              :uuid             not null, primary key
#  address         :text
#  billing_scheme  :integer
#  country_code    :string
#  currency        :string
#  deleted_at      :datetime
#  email           :string
#  mobile          :string
#  name            :string
#  notify_emails   :boolean
#  postal_code     :integer
#  province        :string
#  settings        :jsonb
#  timezone        :string           default("Asia/Karachi")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_type_id :uuid             not null
#  parent_id       :uuid
#
# Indexes
#
#  accounts_name                      (name,deleted_at) UNIQUE
#  index_accounts_on_account_type_id  (account_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_type_id => account_types.id)
#
class Account < ApplicationRecord
  belongs_to :account_type
  has_many :vacations, dependent: :destroy
  has_many :vacation_types, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :forms, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :interviews, dependent: :destroy
  has_many :klass_templates, dependent: :destroy
  has_many :message_templates, dependent: :destroy

  validates :email, :mobile, :postal_code, presence: true
  validates :name, presence: true, uniqueness: { scope: %i[name deleted_at] }
end
