class DvdController < ApplicationController
  def list
    @dvds = Dvd.find(:all)
    @title = "DVD Shelf All DVDs"
  end
  
  def search
    @prev_page = params[:page].to_i - 1
    @next_page = params[:page].to_i + 1
    @dvds = Dvd.search_amazon(params[:dvd_keyword], params[:page], session[:user])
    @keyword = params[:dvd_keyword]
    @title = "DVD Shelf Search Results"
  end
  
  def add
    isbn = params[:isbn]
    dvd = Dvd.find_or_create_from_amazon( isbn , session[:user] )
    if Dvd.number_of_books_exceeded?
      render :text => 'Number of dvds is exceeded'
    else
      if dvd.save
        render :partial => 'dvd_exists', :locals => { :dvd => dvd }
      else
        render :text => 'Failed to add dvd'
      end
    end
  end
  
  def delete
    @dvd = Dvd.find_by_isbn( params[:isbn] )
    current_user = User.find( session[:user] )
    current_user.dvds.delete( @dvd )
    if @dvd.users.size == 0
      Dvd.delete( @dvd.id )
    end
  end
  
  def show
    @dvd = Dvd.find(params[:id])
    @title = "DVD Detail"
  end
end
