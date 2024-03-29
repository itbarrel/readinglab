# frozen_string_literal: true

# == Schema Information
#
# Table name: students
#
#  id                     :uuid             not null, primary key
#  credit_sessions        :integer          default(0)
#  dates                  :string
#  deleted_at             :string
#  dob                    :date
#  first_name             :string
#  gender                 :integer
#  grade                  :string
#  last_name              :string
#  last_session_processed :datetime
#  prepaid_sessions       :integer
#  programs               :string
#  registration_date      :datetime
#  school                 :string
#  session_credit         :integer          default(0)
#  session_processed_at   :datetime
#  settings               :jsonb
#  status                 :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  account_id             :uuid             not null
#  parent_id              :uuid             not null
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
  has_many :approved_vacations, dependent: :destroy

  enum :status, %i[registered scheduled wait_listed active]
  enum :gender, %i[male female others not_mentioned]

  validates :first_name, :last_name, :gender, presence: true

  before_create :set_status

  VIEW_REJECTED_ATTRIBUTES = %i[id first_name last_name settings credit_sessions account_id parent_id account_id created_at updated_at
                                deleted_at].freeze
  DATE_FORMATER_ATTRIBUTES = %i[registration_date last_session_processed].freeze
  VIEW_ADDED_ATTRIBUTES = %i[credit_sessions_to_show].freeze

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
      meeting_ids.push(*x.klass.meetings.where('meetings.starts_at > ?', x.created_at.beginning_of_day).ids)
    end
    meetings.where(id: meeting_ids)
  end

  def payable_meetings
    escape_meeting_time = latest_payment.nil? ? DateTime.new(2000, 1, 1) : latest_payment.meeting.starts_at
    active_meetings.where('meetings.starts_at > ?', escape_meeting_time).order(starts_at: :asc)
  end

  def next_billing_date
    operator = credit_sessions.to_i.positive? ? '>' : '<'
    sorting = credit_sessions.to_i.positive? ? :asc : :desc
    filtered_meetings = billable_meetings.where("starts_at #{operator} ?", Time.zone.now).order(starts_at: sorting)

    filtered_meetings[credit_sessions.to_i]&.starts_at
  end

  def calculated_next_billing_date
    return nil if last_session_processed.blank?

    credit = credit_sessions.to_i + paid_sessions + leave_count

    return nil if credit.negative?

    attended_ids = student_meetings.select do |sm|
      sm.created_at >= last_session_processed.beginning_of_month &&
        sm.created_at <= last_session_processed.end_of_month &&
        [:present, :absent, 'present', 'absent'].include?(sm.attendance)
    end.map(&:meeting_id)

    filtered = active_meetings.select do |meet|
      meet.starts_at >= last_session_processed.beginning_of_month || attended_ids.include?(meet.id)
    end.uniq.sort_by(&:starts_at)

    jump = filtered.length > credit.to_i ? credit.to_i : filtered.length
    filtered[jump]&.starts_at
  end

  def total_sessions
    return 0 if last_session_processed.blank?

    meetings.select do |sm|
      sm.starts_atcreated_at >= last_session_processed.beginning_of_month && sm.starts_at <= last_session_processed.end_of_month
    end.length
  end

  def actual_meetings
    meeting_ids = student_classes.with_deleted.includes([:klass]).map do |x|
      next if x.klass.blank?

      meets = x.klass.meetings.where('starts_at > ?', x.created_at)
      meets = meets.where('starts_at < ?', x.deleted_at) if x.deleted_at.present?
      meets.ids
    end.flatten

    Meeting.where(id: meeting_ids)
  end

  def billable_meetings
    vacation_periods = Vacation.all.map do |vacation|
      (vacation.starting_at..vacation.ending_at)
    end.flatten
    student_vacation_periods = approved_vacations.map do |vacation|
      (vacation.start_date..vacation.end_date)
    end.flatten
    actual_meetings.where.not(starts_at: vacation_periods + student_vacation_periods)
  end

  def leave_count
    return 0 if last_session_processed.blank?

    0
  end

  def attended_sessions
    return 0 if last_session_processed.blank?

    0
  end

  def paid_sessions
    return 0 if last_session_processed.blank?

    0
  end

  def credit_sessions_to_show
    credit_sessions.to_i
    # credit_sessions.to_i + paid_sessions - attended_sessions
  end

  def meeting_purchased
    receipts.sum(:sessions_count)
  end

  def self.to_csv(options = {})
    CSV.generate(headers: true) do |csv|
      all.find_each do |record|
        meeting_ids = record.meetings.where(starts_at: options[:from]..options[:to]).ids
        details = record.form_details.where(parent_type: 'Meeting', parent_id: meeting_ids).map(&:parent_id)
        csv << [record.name, '', record.parent.name]
        csv << []

        details.group_by(&:form).each do |form, values|
          csv << ['Meeting date', 'Form Name', 'Form Sumbmission Date', *form.form_fields.order(:id).map(&:name)]
          values.each do |fd|
            csv << [fd.parent.starts_at, form.name, fd.created_at, *form.form_fields.order(:id).map { |x| fd.form_values[x.model_key] }]
          end
        end
        csv << []
      end
    end
  end
end
