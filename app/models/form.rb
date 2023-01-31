# frozen_string_literal: true

# == Schema Information
#
# Table name: forms
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  fields     :jsonb
#  name       :string
#  purpose    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#
# Indexes
#
#  forms_name                 (account_id,name,deleted_at) UNIQUE
#  index_forms_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Form < ApplicationRecord
  belongs_to :account, dependent: :destroy
  has_many :klass_tempelate_forms, dependent: :destroy
  has_many :attendance_klasses,
           class_name: 'Klass',
           foreign_key: 'attendance_form_id',
           inverse_of: 'form',
           dependent: :destroy

  enum :purpose, %i[lessonable attendancable]

  validates :name, presence: true, uniqueness: { scope: %i[account_id name deleted_at] }
end
