# frozen_string_literal: true

module Randomizer
  extend ActiveSupport::Concern

  included do
  end

  class_methods do
    delegate :sample, to: :all
  end
end
