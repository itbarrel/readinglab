# frozen_string_literal: true

# == Schema Information
#
# Table name: archive_meetings
#
#  id                 :uuid             not null, primary key
#  cancel             :boolean
#  deleted_at         :datetime
#  ends_at            :datetime
#  hold               :boolean
#  meeting_created_at :datetime
#  meeting_deleted_at :datetime
#  meeting_updated_at :datetime
#  starts_at          :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  account_id         :uuid             not null
#  archive_klass_id   :uuid             not null
#
# Indexes
#
#  index_archive_meetings_on_account_id        (account_id)
#  index_archive_meetings_on_archive_klass_id  (archive_klass_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (archive_klass_id => archive_klasses.id)
#
class ArchiveMeeting < ApplicationRecord
  belongs_to :account
  belongs_to :archive_klass
  has_many :payments, dependent: nil
  has_many :archive_student_meetings, dependent: nil
  has_many :archive_form_details, as: :parentable, dependent: nil
  has_many :attentive_students, through: :student_meetings, source: 'student'

  ###### Klass associations #####

  delegate :students, to: :klass
  delegate :teacher, to: :klass
  delegate :room, to: :klass
  delegate :meetings, to: :klass
  delegate :student_classes, to: :klass
  delegate :attendance_form, to: :klass
  delegate :forms, to: :klass
  delegate :name, to: :klass
  delegate :short_name, to: :klass

  has_many :archive_student_meetings, dependent: :destroy
  has_many :archive_form_details, as: :parent, dependent: nil
  has_many :attentive_students, through: :archive_student_meetings, source: 'student'
end
