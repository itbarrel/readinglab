# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#  grade_id   :uuid
#
# Indexes
#
#  book_name                  (account_id,name,deleted_at) UNIQUE
#  index_books_on_account_id  (account_id)
#  index_books_on_grade_id    (grade_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (grade_id => grades.id)
#
class Book < ApplicationRecord
  belongs_to :account
  belongs_to :grade, optional: true

  validates :name, presence: true, uniqueness: { scope: %i[account_id name deleted_at] }
end
