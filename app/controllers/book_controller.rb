class BookController < ApplicationController
  def list
    @books = Book.find(:all)
    @title = "Book Shelf All Books"
  end
  
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
    if Book.number_of_books_exceeded?
      render :text => 'Number of books is exceeded'
    else
      if book.save
        render :partial => 'book_exists', :locals => { :book => book }
      else
        render :text => 'Failed to add book'
      end
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

  def show
    @book = Book.find(params[:id])
    @title = "Book Detail"
  end

  def tag_cloud_user
    @tags = User.find(session[:user]).tags
  end

  def tag_cloud_all
    @tags = Tag.find(:all, :limit => 100, :order => 'taggings_count DESC').sort_by(&:name)
  end

  def show_for_tag
    @tag = params[:id]
    @books = Book.find_tagged_with(@tag)
  end

  def update_tags
    @editor_id = params[:editorId]
    book_id = @editor_id.split('_')[-1]
    tags = params[:value]
    @book = Book.find(book_id)
    @book.user_id = session[:user]
    @book.tag_list = tags
    @book.save
    render :text => @book.tag_list
  end
end
