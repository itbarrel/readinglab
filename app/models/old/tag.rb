# frozen_string_literal: true

class Old::Tag < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  has_many :library_tags, class_name: 'Old::LibraryTag'
  has_many :libraries, through: :library_tags
end
