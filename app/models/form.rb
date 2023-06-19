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

  has_many :attendance_klasses,
           class_name: 'Klass',
           foreign_key: 'attendance_form_id',
           dependent: :nullify,
           inverse_of: 'forms'
  has_many :form_fields, dependent: :destroy
  has_many :form_details, dependent: nil

  has_many :klass_forms, dependent: :destroy

  enum :purpose, %i[lessonable attendancable assessment general]

  validates :name, presence: true, uniqueness: { scope: %i[account_id name deleted_at] }

  accepts_nested_attributes_for :form_fields, allow_destroy: true, reject_if: :all_blank

  def self.default_seeds
    ['Attendance Form']
  end

  def form_duplicate_with_uniqueness_validation
    new_form = dup
    new_form.name = "#{name} (Copy)" # Customize how you want to modify the name here
    unless new_form.valid?
      # Add an error message to the name attribute if it's not unique
      new_form.errors.add(:name, 'must be unique')
    end
    new_form
  end
end
