# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  active                 :boolean          default(TRUE)
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  date_of_hire           :date
#  date_of_inactive       :date
#  deleted_at             :datetime
#  email                  :string           default(""), not null
#  emergency_contact      :string
#  emergency_name         :string
#  encrypted_password     :string           default(""), not null
#  external_user          :boolean
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  phone                  :string
#  postal_code            :string
#  profile                :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  settings               :jsonb
#  sign_in_count          :integer          default(0), not null
#  termination_date       :string
#  undeletable            :boolean
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  account_id             :uuid             not null
#
# Indexes
#
#  index_users_on_account_id            (account_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  users_email                          (account_id,email,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class User < ApplicationRecord
  belongs_to :account
  has_many :form_details, dependent: nil
  has_many :notifications, dependent: :destroy
  # has_and_belongs_to_many :users, :join_table => :users_roles

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  rolify
  has_one_attached :profile

  # enum role: { admin: 0, supervisor: 1, teacher: 2, super_admin: 3 }

  validates :first_name, :last_name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  # accepts_nested_attributes_for :user_roles

  VIEW_REJECTED_ATTRIBUTES = %i[id account_id created_at updated_at deleted_at].freeze

  def name
    "Mr/s. #{first_name} #{last_name}"
  end

  def calendar_name
    "#{first_name} #{last_name}"
  end

  def active_for_authentication?
    super && active?
  end

  def inactive_message
    'User account is inactive'
  end

  def super_admin?
    has_role?(:super_admin, account)
  end

  def admin?
    has_role?(:admin, account)
  end

  def supervisor?
    has_role?(:supervisor, account)
  end

  def teacher?
    has_role?(:teacher, account)
  end
end
