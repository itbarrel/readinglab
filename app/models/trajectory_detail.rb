# frozen_string_literal: true

# == Schema Information
#
# Table name: trajectory_details
#
#  id          :uuid             not null, primary key
#  deleted_at  :datetime
#  entry_date  :datetime
#  error_count :integer
#  grade       :string
#  season      :string
#  status      :integer
#  wpm         :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :uuid             not null
#  book_id     :uuid
#  klass_id    :uuid
#  student_id  :uuid             not null
#
# Indexes
#
#  index_trajectory_details_on_account_id  (account_id)
#  index_trajectory_details_on_book_id     (book_id)
#  index_trajectory_details_on_klass_id    (klass_id)
#  index_trajectory_details_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (klass_id => klasses.id)
#  fk_rails_...  (student_id => students.id)
#
class TrajectoryDetail < ApplicationRecord
  belongs_to :account
  belongs_to :student
  belongs_to :klass
  belongs_to :book
  enum :status, %i[draft published archived]

  validates :wpm, presence: true
end
