# frozen_string_literal: true

# == Schema Information
#
# Table name: library_messages
#
#  id          :integer          not null, primary key
#  active      :boolean          default(TRUE)
#  deleted_at  :datetime
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :uuid
#
# Indexes
#
#  index_library_messages_on_account_id  (account_id)
#
class Old::LibraryMessage < Old::ApplicationRecord
  belongs_to :account
  scope :active, -> { where(active: true) }
  acts_as_paranoid
end
