class CdController < ApplicationController
  def search
    @prev_page = params[:page].to_i - 1
    @next_page = params[:page].to_i + 1
    @cds = Cd.search_amazon(params[:music_keyword], params[:page], session[:user])
    @keyword = params[:music_keyword]
    @title = "CD Shelf Search Results"
  end
  
  def add
    isbn = params[:isbn]
    cd = Cd.find_or_create_from_amazon( isbn , session[:user] )
    if Cd.number_of_cds_exceeded?
      render :text => 'Number of cds is exceeded'
    else
      if cd.save
        render :partial => 'cd_exists', :locals => { :cd => cd }
      else
        render :text => 'Failed to add cd'
      end
    end
  end
  
  def delete
    @cd = Cd.find_by_isbn( params[:isbn] )
    current_user = User.find( session[:user] )
    current_user.cds.delete( @cd )
    if @cd.users.size == 0
      Cd.delete( @cd.id )
    end
  end
  
  def list
    @cds = Cd.find(:all)
    @title = "CD Shelf"
  end
end
