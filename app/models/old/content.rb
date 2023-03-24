# frozen_string_literal: true

# == Schema Information
#
# Table name: content
#
#  id             :uuid             not null, primary key
#  active         :boolean          default(TRUE)
#  author         :string
#  body           :string
#  deleted_at     :datetime
#  description    :string
#  external_url   :string
#  filename       :string
#  filesize       :integer
#  mimetype       :string           not null
#  storage_url    :string
#  title          :string
#  created_at     :datetime
#  updated_at     :datetime
#  account_id     :uuid             not null
#  uploaded_by_id :uuid
#
# Indexes
#
#  index_content_on_account_id      (account_id)
#  index_content_on_uploaded_by_id  (uploaded_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (uploaded_by_id => users.id)
#
class Old::Content < Old::ApplicationRecord
  self.table_name = 'content'
  belongs_to :account
  acts_as_paranoid
  has_many :library_content
  has_many :content_libraries, through: :library_content
  mount_uploader :storage_url, ContentUploader
  before_save :update_asset_attributes
  scope :active, -> { where(active: true) }
end
