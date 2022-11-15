# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # include EsbuildErrorRendering if Rails.env.development?
  before_action :generate_sidebar, unless: :json_request?

  def generate_sidebar
    @menu_list = [
      { url: '/', text: 'Dashboard', class: '', icon: 'micon bi bi-house', sub_items: [] },
      { url: '/calendar', text: 'Calendar', class: '', icon: 'micon bi bi-calendar4-week', sub_items: [] },
      { text: 'Settings', class: '', icon: 'micon bi bi-basket', sub_items: [
        { url: '/staff', text: 'Staff', class: '', icon: 'micon bi bi-people' },
        { url: '/profile', text: 'Profile', class: '', icon: 'micon bi bi-person' }
      ] }
    ]
  end

  private

  def json_request?
    request.format.symbol == :json
  end
end
