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
#  gender            :integer
#  grade             :string
#  last_name         :string
#  prepaid_sessions  :integer
#  programs          :string
#  registration_date :datetime
#  school            :string
#  settings          :jsonb
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
# ff0eedf6-77d9-49c8-b30f-5d5f8b89a814
class Student < ApplicationRecord
  belongs_to :account
  belongs_to :parent
  has_many :interviews, dependent: :destroy
  has_one :latest_interview, -> { order created_at: :desc },
          class_name: 'Interview',
          foreign_key: 'student_id',
          dependent: :destroy,
          inverse_of: 'student'
  has_one :latest_attendance, -> { order created_at: :desc },
          class_name: 'StudentMeeting',
          foreign_key: 'student_id',
          dependent: :destroy,
          inverse_of: 'student'
  has_many :student_classes, dependent: :destroy
  has_many :klasses, through: :student_classes
  has_many :meetings, through: :klasses # faulty
  has_many :student_meetings, dependent: nil
  has_many :form_details, dependent: nil
  has_many :payments, dependent: nil
  has_many :receipts, dependent: :destroy
  has_many :notices, dependent: :destroy

  enum :status, %i[registered scheduled wait_listed active]
  enum :gender, %i[male female others not_mentioned]

  validates :first_name, :last_name, :gender, presence: true

  before_create :set_status

  ransacker :status do |parent|
    parent.table[:status]
  end

  ransacker :identifer, formatter: proc { |value| value.downcase } do |parent|
    Arel::Nodes::NamedFunction.new('CONCAT_WS', [
                                     Arel::Nodes.build_quoted(' '),
                                     parent.table[:first_name],
                                     parent.table[:last_name]
                                   ])
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
    self.status = :registered if status.blank?
  end

  def self.eligible_for_klass(klass_id)
    student_ids = StudentClass.where(klass_id:).map(&:student_id).compact
    all.where(status: %i[wait_listed active]).where.not(id: student_ids)
  end

  def name
    "#{first_name.capitalize} #{last_name}"
  end

  # wrong
  def latest_payment
    payments.joins(:meeting).order('meetings.starts_at desc').first
  end

  def active_meetings
    meeting_ids = []
    student_classes.each do |x|
      meeting_ids.push(*x.klass.meetings.where('meetings.starts_at > ?', x.created_at).ids)
    end
    meetings.where(id: meeting_ids)
  end

  def payable_meetings
    escape_meeting_time = latest_payment.nil? ? DateTime.new(2000, 1, 1) : latest_payment.meeting.starts_at
    active_meetings.where('meetings.starts_at > ?', escape_meeting_time).order(starts_at: :asc)
  end

  def next_billing_date
    payable_meetings&.first&.starts_at
  end

  def total_sessions
    student_meetings.length
  end

  def leave_count
    student_meetings.leave.length
  end

  def sessions_count
    student_meetings.present.length
  end

  def meeting_purchased
    count = 0
    receipts.each do |recp|
      count += recp.sessions_count
    end
    count
  end
end
