# frozen_string_literal: true

class Old::Role < Old::ApplicationRecord
  has_and_belongs_to_many :users, join_table: :users_roles
  acts_as_paranoid
  scope :active, -> { where(active: true) }

  # belongs_to :resource,
  #            :polymorphic => true,
  #            :optional => true

  # validates :resource_type,
  #           :inclusion => { :in => Rolify.resource_types },
  #           :allow_nil => true
end
