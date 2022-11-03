# frozen_string_literal: true

# == Schema Information
#
# Table name: students
#
#  id                :uuid             not null, primary key
#  credit_session    :integer
#  dates             :string
#  deleted_at        :string
#  dob               :date
#  first_name        :string
#  grade             :string
#  last_name         :string
#  prepaid_sessions  :integer
#  programs          :string
#  registration_date :datetime
#  school            :string
#  settings          :jsonb
#  sex               :string
#  status            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  account_id        :uuid             not null
#  parent_id         :uuid             not null
#
# Indexes
#
#  index_students_on_account_id  (account_id)
#  index_students_on_parent_id   (parent_id)
#  students_name                 (account_id,first_name,last_name,parent_id,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (parent_id => parents.id)
#
class Student < ApplicationRecord
  belongs_to :account
  belongs_to :parent
  has_many :student_classes, dependent: :destroy
  enum :status, %i[registrated on_interview wait_list active]
  before_create :set_status

  validates :first_name, :last_name, :school, presence: true

  def self.available_at(start_date = DateTime.now, duration = 60)
    end_date = start_date + duration.minutes
    meetings = Meeting.where('starts_at <= ? and ? <= ends_at', end_date, start_date).includes(:students)
    student_ids = meetings.map do |m|
      m.students.ids
    end

    Student.where.not(id: student_ids.flatten)
  end

  def set_status
    update(status: 'registrated') if status.blank?
  end
end
