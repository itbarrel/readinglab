# frozen_string_literal: true

# == Schema Information
#
# Table name: class_templates
#
#  id            :uuid             not null, primary key
#  active        :boolean          default(TRUE), not null
#  deleted_at    :datetime
#  description   :text
#  duration      :interval         default(1 hour), not null
#  friday        :boolean          default(FALSE), not null
#  max_students  :integer          default(0), not null
#  min_students  :integer
#  monday        :boolean          default(FALSE), not null
#  name          :string
#  range_type    :string           default("sessions")
#  saturday      :boolean          default(FALSE), not null
#  session_range :integer          default(8)
#  settings      :jsonb
#  start         :datetime
#  sunday        :boolean          default(FALSE), not null
#  thursday      :boolean          default(FALSE), not null
#  tuesday       :boolean          default(FALSE), not null
#  wednesday     :boolean          default(FALSE), not null
#  created_at    :datetime
#  updated_at    :datetime
#  account_id    :uuid             not null
#  room_id       :uuid
#  teacher_id    :uuid
#
# Indexes
#
#  index_class_templates_on_account_id  (account_id)
#  index_class_templates_on_room_id     (room_id)
#  index_class_templates_on_teacher_id  (teacher_id)
#
class Old::ClassTemplate < Old::ApplicationRecord
  self.table_name = 'class_templates'
  belongs_to :account, class_name: 'Old::Account'
  has_many :r_classes, class_name: 'Old::RClass'
  belongs_to :teacher, class_name: 'User'
  belongs_to :room, class_name: 'Old::Room'
  has_many :class_template_forms, class_name: 'Old::ClassTemplateForm'
  has_many :forms, through: :class_template_forms, class_name: 'Old::Form'
  acts_as_paranoid
  scope :active, -> { where(active: true) }
end
