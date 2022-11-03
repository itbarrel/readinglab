# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
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
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer
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
class Teacher < User
  has_many :klass_templates, dependent: :nullify, foreign_key: 'user_id', inverse_of: 'Teacher'
  has_many :klasses, dependent: :nullify

  default_scope { teacher }

  before_save :default_type

  def default_type
    self.role ||= :teacher
  end

  def self.available_at(start_date = DateTime.now, duration = 60)
    end_date = start_date + duration.minutes
    meetings = Meeting.where('starts_at <= ? and ? <= ends_at', end_date, start_date).includes(klass: :teacher)
    teacher_ids = meetings.map do |m|
      m.klass.teacher.id
    end

    Teacher.where.not(id: teacher_ids)
  end
end
