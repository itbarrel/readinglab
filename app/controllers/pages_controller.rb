# frozen_string_literal: true

class PagesController < ApplicationController
  def home; end

  def calendar; end

  def communication
    authorize! :read, :communication
    @students = []
    @users = []
  end

  def profile; end

  def health
    head :ok
  end
end
