# frozen_string_literal: true

# == Schema Information
#
# Table name: klass_templates
#
#  id            :uuid             not null, primary key
#  deleted_at    :datetime
#  description   :text
#  duration      :integer
#  friday        :boolean          default(FALSE)
#  max_students  :integer
#  monday        :boolean          default(FALSE)
#  name          :string
#  saturday      :boolean          default(FALSE)
#  session_range :integer          default(8)
#  settings      :jsonb
#  start         :datetime
#  sunday        :boolean          default(FALSE)
#  thursday      :boolean          default(FALSE)
#  tuesday       :boolean          default(FALSE)
#  wednesday     :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :uuid             not null
#  room_id       :uuid
#  teacher_id    :uuid
#
# Indexes
#
#  index_klass_templates_on_account_id  (account_id)
#  index_klass_templates_on_room_id     (room_id)
#  index_klass_templates_on_teacher_id  (teacher_id)
#  klass_templates_name                 (account_id,name,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (room_id => rooms.id)
#  fk_rails_...  (teacher_id => users.id)
#
class KlassTemplate < ApplicationRecord
  belongs_to :account
  belongs_to :teacher
  belongs_to :room
  has_many :klasses, dependent: :nullify

  validates :name, presence: true, uniqueness: { scope: %i[account_id name deleted_at] }
  validates :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, inclusion: { in: [true, false] }
end
