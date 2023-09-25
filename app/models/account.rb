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
  resourcify

  has_one :admin, -> { admin }, class_name: 'User', dependent: :destroy, inverse_of: :account
  has_many :vacations, dependent: :destroy
  has_many :vacation_types, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :teachers, class_name: 'Teacher', dependent: :destroy, inverse_of: :account
  has_many :rooms, dependent: :destroy
  has_many :forms, dependent: :destroy
  has_many :form_details, dependent: :destroy
  has_many :parents, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :meetings, dependent: :destroy
  has_many :student_meetings, dependent: :destroy
  has_many :interviews, dependent: :destroy
  has_many :content_libraries, dependent: :destroy
  has_many :klass_templates, dependent: :destroy
  has_many :klasses, dependent: :destroy
  has_many :trajectory_details, dependent: :destroy
  has_many :message_templates, dependent: :destroy
  has_many :receipt_types, dependent: :destroy
  has_many :receipts, dependent: :destroy
  has_many :vaction_types, dependent: :destroy
  has_many :vacations, dependent: :destroy
  has_many :grades, dependent: :destroy
  has_many :books, dependent: :destroy

  validates :email, :mobile, :postal_code, presence: true
  validates :name, presence: true, uniqueness: { scope: %i[name deleted_at] }

  after_initialize :set_default_values

  accepts_nested_attributes_for :admin

  enum :billing_scheme, %i[sessionly monthly annual]

  def self.default_seeds
    %w[ReadingLab]
  end

  def set_default_values
    self.notify_emails = true if new_record?
  end

  def admins
    admins = users.with_role(:admin, self)
    admins = users.with_role(:supervisor, self) if admins.empty?
    admins
  end
end
