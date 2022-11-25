# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  # include EsbuildErrorRendering if Rails.env.development?
  before_action :generate_sidebar, unless: :json_request?

  def generate_sidebar
    @menu_list = [
      { url: '/', text: 'Dashboard', class: '', icon: 'micon bi bi-house', sub_items: [] },
      { url: '/calendar', text: 'Calendar', class: '', icon: 'micon bi bi-calendar4-week', sub_items: [] },
      { text: 'Registration', class: '', icon: 'micon bi bi-basket', sub_items: [
        { url: '/parents', text: 'Parents', class: '', icon: 'micon bi bi-people' },
        { url: '/students', text: 'Student Listing', class: '', icon: 'micon fa fa-plane' },
        { url: '/interviews', text: 'Interviews', class: '', icon: 'micon fa fa-group' }

      ] },
      { text: 'Classes', class: '', icon: 'micon bi bi-basket', sub_items: [
        { url: '/klasses', text: 'Active', class: '', icon: 'micon bi bi-book' },
        { url: '/rooms', text: 'Obselote', class: '', icon: 'micon fa fa-bank' }

      ] },
      { url: '/communication', text: 'Communication', class: '', icon: 'micon bi bi-calendar4-week', sub_items: [] },

      { text: 'Settings', class: '', icon: 'micon bi bi-basket', sub_items: [
        { url: '/klass_templates', text: 'Class tempelate ', class: '', icon: 'micon bi bi-book' },
        { url: '/rooms', text: 'rooms', class: '', icon: 'micon fa fa-bank' },
        { url: '/staffs', text: 'Staff', class: '', icon: 'micon bi bi-people' },
        { url: '/vacations', text: 'Vacations', class: '', icon: 'micon fa fa-plane' },
        { url: '/profile', text: 'Profile', class: '', icon: 'micon bi bi-person' }
      ] }
    ]
  end

  private

  def json_request?
    request.format.symbol == :json
  end
end
