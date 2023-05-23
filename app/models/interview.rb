# frozen_string_literal: true

# == Schema Information
#
# Table name: interviews
#
#  id         :uuid             not null, primary key
#  date       :datetime
#  deleted_at :datetime
#  feedback   :string
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#  form_id    :uuid             not null
#  student_id :uuid             not null
#
# Indexes
#
#  index_interviews_on_account_id  (account_id)
#  index_interviews_on_form_id     (form_id)
#  index_interviews_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (form_id => forms.id)
#  fk_rails_...  (student_id => students.id)
#
class Interview < ApplicationRecord
  belongs_to :account
  belongs_to :form
  belongs_to :student
  has_many :form_details, as: :parent, dependent: nil

  enum :status, %i[done waiting cancel]

  validates :date, :status, presence: true

  after_save :set_student_status
  after_destroy :set_student_default_status
  before_validation :set_status

  def set_student_status
    student.scheduled! if student.registered? && waiting?
    student.registered! if student.scheduled? && cancel?
  end

  def set_status
    self.status = :waiting if status.blank?
  end

  def set_student_default_status
    student.registered! if student.scheduled? && waiting?
  end
end
