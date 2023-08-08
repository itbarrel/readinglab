# frozen_string_literal: true

class NoticesController < ApplicationController
  def index
    @notices = Notice.all
  end
end
