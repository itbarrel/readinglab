# frozen_string_literal: true

class ReportsController < ApplicationController
  def graph; end

  def index; end

  def daily
    @reports = Klass.all
  end
end
