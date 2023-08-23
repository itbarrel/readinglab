# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id         :uuid             not null, primary key
#  capacity   :integer
#  color      :string
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#
# Indexes
#
#  index_rooms_on_account_id  (account_id)
#  rooms_name                 (account_id,name,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Room < ApplicationRecord
  belongs_to :account
  has_many :klasses, dependent: :nullify
  has_many :klass_templates, dependent: :nullify
  has_many :allocations, as: :substance, dependent: nil

  validates :name, presence: true, uniqueness: { scope: %i[account_id name deleted_at] }
  validates :capacity, presence: true

  VIEW_REJECTED_ATTRIBUTES = %i[id name account_id created_at updated_at deleted_at].freeze

  def self.available_at(start_date = DateTime.now, duration = 60)
    end_date = start_date + duration.minutes
    meetings = Meeting.where('starts_at <= ? and ? <= ends_at', end_date, start_date).includes(klass: :room)
    room_ids = meetings.map do |m|
      m.klass.room.id
    end

    all.where.not(id: room_ids)
  end
end
