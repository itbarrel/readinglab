# frozen_string_literal: true

class ContentLibrary < ApplicationRecord
  belongs_to :account
  has_many :library_content
  acts_as_paranoid
  belongs_to :parent
  has_many :content, through: :library_content
  has_many :library_tags
  has_many :tags, through: :library_tags
  scope :active, -> { where(active: true) }
end
