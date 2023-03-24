# frozen_string_literal: true

class Old::User < Old::ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :account, class_name: 'Old::Account'
  has_many :meetings, through: :r_classes
  has_many :r_classes, foreign_key: 'teacher_id'
  has_many :assessments, class_name: 'Old::Assesment'
  has_many :salaries, class_name: 'Old::Salary'
  has_many :student_class_histories, class_name: 'Old::StudentClassHistory'
  has_and_belongs_to_many :roles, join_table: :users_roles, class_name: 'Old::Role'

  scope :active, -> { where(active: true) }
  def role
    roles.try(:first).try(:name)
  end

  def name
    "#{first} #{last}"
  end

  def self.is_valid_user(email, password)
    @user = User.find_by(email:)
    @user and @user.valid_password?(password) ? @user : nil
  end

  scope :teachers, -> { joins(:roles).includes(:roles).where('roles.name = ?', 'teacher') }
end
