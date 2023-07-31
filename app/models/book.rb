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
class Book < ApplicationRecord
  belongs_to :account
  belongs_to :klass, optional: true
  validates :name, presence: true, uniqueness: { scope: %i[account_id name deleted_at] }
end
