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

  validates :father_first, :mother_first, :father_phone, presence: true
  validates :father_email, presence: true

  VIEW_REJECTED_ATTRIBUTES = %i[id father_first father_last mother_first mother_last account_id mother_email mother_phone mother_last city_id
                                created_at updated_at deleted_at].freeze
  VIEW_ADDED_ATTRIBUTES = %i[father_name mother_name].freeze

  accepts_nested_attributes_for :children, allow_destroy: true, reject_if: :all_blank

  ransacker :status do |parent|
    parent.table[:status]
  end

  ransacker :identifer, formatter: proc { |value| value.downcase } do |parent|
    Arel::Nodes::NamedFunction.new('CONCAT_WS', [
                                     Arel::Nodes.build_quoted(' '),
                                     parent.table[:father_first],
                                     parent.table[:father_last],
                                     parent.table[:mother_first],
                                     parent.table[:mother_last],
                                     parent.table[:father_email],
                                     parent.table[:mother_email]
                                   ])
  end

  def self.notify_all_about_klass(options)
    all.find_each(batch_size: 10) do |p|
      p.notify_all_about_klass(options)
    end
  end

  def notify_about_klass(options)
    ParentMailer.mailer(self, options).deliver
  end

  def name
    "#{father_first} #{father_last} & #{mother_first} #{mother_last}"
  end

  def father_name
    "#{father_first} #{father_last}"
  end

  def mother_name
    "#{mother_first} #{mother_last}"
  end
end
