# frozen_string_literal: true

# == Schema Information
#
# Table name: forms
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
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
  belongs_to :account
  has_many :klass_forms, dependent: :destroy
  has_many :attendance_klasses,
           class_name: 'Klass',
           foreign_key: 'attendance_form_id',
           dependent: :nullify,
           inverse_of: 'forms'
  has_many :form_fields, dependent: :destroy

  enum :purpose, %i[lessonable attendancable]

  validates :name, presence: true, uniqueness: { scope: %i[account_id name deleted_at] }

  accepts_nested_attributes_for :form_fields, allow_destroy: true, reject_if: :all_blank
end
