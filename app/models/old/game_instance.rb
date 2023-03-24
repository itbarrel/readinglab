# frozen_string_literal: true

# == Schema Information
#
# Table name: game_instances
#
#  id                    :uuid             not null, primary key
#  active                :boolean          default(TRUE)
#  actual_start          :datetime
#  deleted_at            :datetime
#  nominal_start         :datetime
#  release_background_at :datetime
#  created_at            :datetime
#  updated_at            :datetime
#  account_id            :uuid             not null
#  instructor_id         :uuid
#  template_id           :uuid             not null
#
# Indexes
#
#  index_game_instances_on_account_id     (account_id)
#  index_game_instances_on_instructor_id  (instructor_id)
#  index_game_instances_on_template_id    (template_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (instructor_id => users.id) ON DELETE => cascade
#  fk_rails_...  (template_id => role_play_game_templates.id) ON DELETE => cascade
#
class Old::GameInstance < Old::ApplicationRecord
  belongs_to :account
  belongs_to :template
  has_many :role_assignments
  has_many :message_controls
  acts_as_paranoid
  scope :active, -> { where(active: true) }
end
