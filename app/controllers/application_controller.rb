# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :generate_sidebar, unless: :json_request?

  def generate_sidebar
    @menu_list = [
      { url: '/', text: 'Dashboard', class: '', icon: 'micon bi bi-house', sub_items: [] },
      { url: '/calendar', text: 'Calendar', class: '', icon: 'micon bi bi-calendar4-week', sub_items: [] },
      { text: 'Settings', class: '', icon: 'micon bi bi-basket', sub_items: [
        { url: '/staffs', text: 'Staff', class: '', icon: 'micon bi bi-people' },
        { url: '/vacations', text: 'Vacations', class: '', icon: 'micon fa fa-plane' },
        { url: '/rooms', text: 'rooms', class: '', icon: 'micon fa fa-bank' },
        { url: '/interviews', text: 'interviews', class: '', icon: 'micon fa fa-group' },
        { url: '/profile', text: 'Profile', class: '', icon: 'micon bi bi-person' }
      ] }
    ]
  end

  private

  def json_request?
    request.format.symbol == :json
  end
end
