# frozen_string_literal: true

class Old::RClass < Old::ApplicationRecord
  self.table_name = 'r_classes'
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :teacher, class_name: 'User'
  belongs_to :room, class_name: 'Old::Room'
  belongs_to :class_template, class_name: 'Old::ClassTemplate'
  has_many :student_classes, dependent: :destroy, class_name: 'Old::StudentClass'
  has_many :meetings, dependent: :destroy, class_name: 'Old::Meeting'
  has_many :student_class_histories, dependent: :destroy, class_name: 'Old::StudentClassHistory'
  has_many :books, dependent: :destroy, class_name: 'Old::Book'
  # has_many :trajectory_details
  has_many :student_meetings, through: :meetings, class_name: 'Old::StudentMeeting'
  acts_as_paranoid
  scope :active, -> { where(active: true) }
end
