# frozen_string_literal: true

# == Schema Information
#
# Table name: content_libraries
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  public     :boolean
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#
# Indexes
#
#  content_libraries_name                 (account_id,title,deleted_at) UNIQUE
#  index_content_libraries_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class ContentLibrary < ApplicationRecord
  belongs_to :account

  validates :title, presence: true, uniqueness: { scope: %i[name deleted_at] }
end
