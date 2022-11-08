# frozen_string_literal: true

# == Schema Information
#
# Table name: klasses
#
#  id                 :uuid             not null, primary key
#  deleted_at         :datetime
#  duration           :integer
#  friday             :boolean          default(FALSE)
#  max_students       :integer
#  min_students       :integer
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
#  index_klasses_on_account_id          (account_id)
#  index_klasses_on_attendance_form_id  (attendance_form_id)
#  index_klasses_on_klass_template_id   (klass_template_id)
#  index_klasses_on_room_id             (room_id)
#  index_klasses_on_teacher_id          (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (attendance_form_id => forms.id)
#  fk_rails_...  (klass_template_id => klass_templates.id)
#  fk_rails_...  (room_id => rooms.id)
#  fk_rails_...  (teacher_id => users.id)
#
require 'test_helper'

class KlassTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
