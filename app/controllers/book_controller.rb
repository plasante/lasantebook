class BookController < ApplicationController
  def search
    @books = Book.search_amazon(params[:book_keyword], params[:page], session[:user])
    @title = "Book Shelf Search Results"
  end
end
