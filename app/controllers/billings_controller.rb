# frozen_string_literal: true

class BillingsController < ApplicationController
  load_and_authorize_resource :students, class: 'Student', parent: false

  def students
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @students.ransack(params[:q])
    @search.sorts = 'first_name asc' if @search.sorts.empty?
    @pagy, @students = pagy(@search.result.includes(:parent), items: per_page)
  end
end
