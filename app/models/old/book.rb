# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  grade      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#  klass_id   :uuid             not null
#
# Indexes
#
#  book_name                  (account_id,name,deleted_at) UNIQUE
#  index_books_on_account_id  (account_id)
#  index_books_on_klass_id    (klass_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (klass_id => klasses.id)
#
class Old::Book < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :r_class, class_name: 'Old::RClass'
  has_many :trajectory_details, class_name: 'Old::TrajectoryDetail'
  acts_as_paranoid
  scope :active, -> { where(active: true) }
end
