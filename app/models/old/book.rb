# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id         :uuid             not null, primary key
#  active     :boolean          default(TRUE)
#  deleted_at :datetime
#  grade      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid
#  r_class_id :uuid
#
# Indexes
#
#  index_books_on_account_id  (account_id)
#  index_books_on_r_class_id  (r_class_id)
#
class Old::Book < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :r_class, class_name: 'Old::RClass'
  has_many :trajectory_details, class_name: 'Old::TrajectoryDetail'
  acts_as_paranoid
  scope :active, -> { where(active: true) }
end
