# frozen_string_literal: true

class ReportsController < ApplicationController
  def graph; end

  def daily
    @klass = Klass.all
  end
end
