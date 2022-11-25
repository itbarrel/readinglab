# frozen_string_literal: true

# == Schema Information
#
# Table name: parents
#
#  id           :uuid             not null, primary key
#  address      :text
#  deleted_at   :datetime
#  father_email :string
#  father_first :string
#  father_last  :string
#  father_phone :string
#  mother_email :string
#  mother_first :string
#  mother_last  :string
#  mother_phone :string
#  postal_code  :string
#  state        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :uuid             not null
#  city_id      :uuid             not null
#
# Indexes
#
#  index_parents_on_account_id  (account_id)
#  index_parents_on_city_id     (city_id)
#  parents_name                 (account_id,father_email,mother_email,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (city_id => cities.id)
#
class Parent < ApplicationRecord
  belongs_to :account
  belongs_to :city
  has_many :children, class_name: 'Student', dependent: :destroy

  validates :father_first, :father_last, :mother_first, :mother_last, :father_phone, :mother_phone, :address,
            :postal_code, presence: true

  validates :father_email, :mother_email, presence: true

  def self.notify_all_about_klass
    all.find_each(batch_size: 10, &:notify_about_klass)
  end

  def notify_about_klass
    ParentMailer.klass_mailer(self).deliver
  end

  def name
    "(#{father_first} #{father_last} + #{mother_first} #{mother_last})"
  end
end
