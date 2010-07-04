class BookController < ApplicationController
  def search
    @prev_page = params[:page].to_i - 1
    @next_page = params[:page].to_i + 1
    @books = Book.search_amazon(params[:book_keyword], params[:page], session[:user])
    @keyword = params[:book_keyword]
    @title = "Book Shelf Search Results"
  end

  def add
    isbn = params[:isbn]
    book = Book.find_or_create_from_amazon( isbn , session[:user] )
    if book.save
      render :partial => 'book_exists', :locals => { :book => book }
    else
      render :text => 'Failed to add book'
    end
  end

  def delete
    @book = Book.find_by_isbn( params[:isbn] )
    current_user = User.find( session[:user] )
    current_user.books.delete( @book )
    if @book.users.size == 0
      Book.delete( @book.id )
    end
  end
end
