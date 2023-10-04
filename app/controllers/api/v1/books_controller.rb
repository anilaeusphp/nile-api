module Api
  module V1
    class BooksController < ApplicationController
      before_action :set_book, only: [:destroy]

      def index
        books = Book.limit(params[:limit]).offset(params[:offset])
        render json: BooksRepresenter.new(books).as_json, status: :ok
      end

      def create
        author = Author.create!(author_params)
        book = Book.new(book_params.merge(author_id: author.id))

        if book.save
          render json: book, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @book.destroy!
          render json: "Book has been deleted", status: :no_content
        end
      end

      private
      def book_params
        params.require(:book).permit(:title)
      end

      private
      def author_params
        params.require(:author).permit(:first_name, :last_name, :age)
      end

      private
      def set_book
        @book = Book.find(params[:id])
      end

    end
  end
end
