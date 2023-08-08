# frozen_string_literal: true

# == Schema Information
#
# Table name: archive_klasses
#
#  id                 :uuid             not null, primary key
#  deleted_at         :datetime
#  duration           :integer
#  friday             :boolean          default(FALSE)
#  klass_created_at   :datetime
#  klass_deleted_at   :datetime
#  klass_updated_at   :datetime
#  max_students       :integer
#  min_students       :integer          default(0)
#  monday             :boolean          default(FALSE)
#  range_type         :integer
#  saturday           :boolean          default(FALSE)
#  session_range      :integer          default(8)
#  starts_at          :datetime
#  sunday             :boolean          default(FALSE)
#  thursday           :boolean          default(FALSE)
#  tuesday            :boolean          default(FALSE)
#  wednesday          :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  account_id         :uuid             not null
#  attendance_form_id :uuid
#  klass_template_id  :uuid
#  room_id            :uuid
#  teacher_id         :uuid
#
# Indexes
#
#  index_archive_klasses_on_account_id          (account_id)
#  index_archive_klasses_on_attendance_form_id  (attendance_form_id)
#  index_archive_klasses_on_klass_template_id   (klass_template_id)
#  index_archive_klasses_on_room_id             (room_id)
#  index_archive_klasses_on_teacher_id          (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (attendance_form_id => forms.id)
#  fk_rails_...  (klass_template_id => klass_templates.id)
#  fk_rails_...  (room_id => rooms.id)
#  fk_rails_...  (teacher_id => users.id)
#
class ArchiveKlass < ApplicationRecord
  belongs_to :account
  belongs_to :teacher, optional: true
  belongs_to :room, optional: true
  belongs_to :klass_template, optional: true
  belongs_to :attendance_form, optional: true, class_name: 'Form'

  has_many :notifications, as: :record, dependent: nil
  has_many :allocated_resources, as: :allocatee, class_name: 'Allocation', dependent: nil
  has_many :klass_forms, dependent: :destroy
  has_many :forms, through: :klass_forms
  # has_many :student_forms, through: :student_classes

  has_many :student_classes, dependent: :destroy
  has_many :students, through: :student_classes
  # has_many :student_forms, through: :student_classes

  has_many :student_forms, dependent: :destroy
  has_many :archive_meetings, dependent: :destroy
  has_many :archive_student_meetings, through: :meetings, dependent: :destroy
end
