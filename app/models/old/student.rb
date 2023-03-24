# frozen_string_literal: true

class Old::Student < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :parent, class_name: 'Old::Parent'
  has_one :assessment, class_name: 'Old::Assesment'
  has_many :paid_student_sessions, class_name: 'Old::PaidStudentSession'
  # has_and_belongs_to_many :meetings
  has_many :receipts, class_name: 'Old::Receipt'
  has_many :interviews, class_name: 'Old::Interview'
  has_many :student_classes, class_name: 'Old::StudentClass'
  has_many :student_meetings, class_name: 'Old::StudentMeeting'
  has_many :completed_lessons, class_name: 'Old::CompletedLesson'
  has_many :trajectory_details, class_name: 'Old::TrajectoryDetail'
  has_many :student_class_histories, class_name: 'Old::StudentClassHistory'

  has_many :interview_results, class_name: 'Old::InterviewResult'

  has_many :r_classes, through: :student_classes, class_name: 'Old::RClass'
  acts_as_paranoid
  scope :active, -> { where(active: true) }

  def parent_name
    parent.name || ''
  end

  def name
    s = ''
    s = first if first
    s += ' ' if first && last
    s += last if last
    # add parents names
    pname = parent.name
    s += " (#{pname})" if pname
    s
  end
end
