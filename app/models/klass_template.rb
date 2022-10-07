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
#  session_range :integer
#  settings      :jsonb
#  start         :datetime
#  sunday        :boolean          default(FALSE)
#  thursday      :boolean          default(FALSE)
#  tuesday       :boolean          default(FALSE)
#  wednesday     :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :uuid             not null
#  user_id       :uuid
#
# Indexes
#
#  index_klass_templates_on_account_id  (account_id)
#  index_klass_templates_on_user_id     (user_id)
#  klass_templates_name                 (account_id,name,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (user_id => users.id)
#
class KlassTemplate < ApplicationRecord
  belongs_to :account
  belongs_to :user
  has_many :klass_template_forms, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: %i[account_id name deleted_at] }
  validates :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, inclusion: { in: [true, false] }
end
