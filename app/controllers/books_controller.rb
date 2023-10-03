class BooksController < ApplicationController
  before_action :set_book, only: [:destroy]

  def index
    render json: Book.all, status: :ok
  end

  def create
    book = Book.new(book_params)

    if book.save
      render json: book, status: :created
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @book.destroy
      render json: "Book has been deleted", status: :no_content
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :author)
  end

  private
  def set_book
    @book = Book.find(params[:id])
  end
end
