class BookController < ApplicationController
  def search
    @prev_page = params[:page].to_i - 1
    @next_page = params[:page].to_i + 1
    @books = Book.search_amazon(params[:book_keyword], params[:page], session[:user])
    @keyword = params[:book_keyword]
    @title = "Book Shelf Search Results"
  end
end
