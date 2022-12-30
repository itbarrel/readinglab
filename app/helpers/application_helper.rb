# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def false?(obj)
    [false, 'false'].include?(obj)
  end

  def true?(obj)
    [true, 'true'].include?(obj)
  end
end
