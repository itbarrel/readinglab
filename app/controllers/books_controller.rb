# frozen_string_literal: true

class BooksController < ApplicationController
  load_and_authorize_resource
  before_action :set_book, only: %i[]

  # GET /books or /books.json
  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @books.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @books = pagy(@search.result, items: per_page)
  end

  # GET /books/1 or /books/1.json
  def show; end

  # GET /books/new
  def new
    @book = current_account.books.new
  end

  # GET /books/1/edit
  def edit; end

  # POST /books or /books.json
  def create
    @book = current_account.books.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to request.referer, notice: 'Book has been successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        process_errors(@book)
        format.html { redirect_to request.referer }
        format.json { render json: @book.errors }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to request.referer, notice: 'Book has been successfully updated.' }
        format.json { render :index, status: :ok, location: @book }
      else
        format.html { redirect_to request.referer }
        format.json { render json: @book.errors }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Book has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = current_account.books.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:name, :grade, :klass_id)
  end
end
