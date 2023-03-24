# frozen_string_literal: true

class Old::ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  connects_to database: { reading: :old_readinglab, writing: :old_readinglab }
end
