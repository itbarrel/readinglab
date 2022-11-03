# frozen_string_literal: true

# == Schema Information
#
# Table name: forms
#
#  id            :uuid             not null, primary key
#  attendancable :boolean          default(FALSE)
#  deleted_at    :datetime
#  fields        :jsonb
#  lessonable    :boolean          default(FALSE)
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :uuid             not null
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

  has_many :attendance_meetings, class_name: 'Meeting', foreign_key: 'attendance_form_id', dependent: :destroy,
                                 inverse_of: :meeting

  validates :name, presence: true, uniqueness: { scope: %i[account_id name deleted_at] }
end
