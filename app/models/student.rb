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
  has_one :interview, dependent: :destroy
  has_many :student_classes, dependent: :destroy
  enum :status, %i[registered scheduled wait_listed active]
  before_create :set_status

  validates :first_name, :last_name, :school, presence: true

  ransacker :status do |parent|
    parent.table[:status]
  end

  def self.ids_studing_at(start_date = DateTime.now, duration = 60)
    end_date = start_date + duration.minutes
    meetings = Meeting.where('starts_at <= ? and ? <= ends_at', end_date, start_date).includes(klass: :students)
    student_ids = meetings.map do |m|
      m.klass.students.ids
    end
    student_ids.flatten
  end

  def self.studing_at(start_date = DateTime.now, duration = 60)
    Student.where(id: ids_studing_at(start_date, duration))
  end

  def self.available_at(start_date = DateTime.now, duration = 60)
    Student.where.not(id: studing_at(start_date, duration))
  end

  def set_status
    registered! if status.blank?
  end

  def self.eligible_for_klass
    all.where(status: %i[wait_list active])
  end

  def name
    "#{first_name.capitalize} #{last_name}"
  end
end
