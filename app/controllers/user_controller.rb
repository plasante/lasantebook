class UserController < ApplicationController
  before_filter :login_required, :only => ['home']

  def signup
    @title = "Signup"
    if request.post? and params[:user]
      @user = User.new(params[:user])
      if User.number_of_users_exceeded?
        flash[:error] = "Number of users is exceeded"
      else
        if @user.save
          session[:user] = @user
          flash[:notice] = "User #{@user.login} created!"
          redirect_to :action => "home"
        else
          flash[:error] = "Signup unsuccessful"
        end
      end
    end
  end
  
  def home
    current_user = User.find( session[:user] )
    @items = params[:items]
    if @items == 'books'
      @books = current_user.books
      @title = "Book Shelf"
    elsif @items == 'dvds'
      @dvds = current_user.dvds
      @title = "DVD Shelf"
    else
      @cds = current_user.cds
      @title = "CD Shelf"
    end
  end

  def login
    if request.post?
      user = User.authenticate(params[:user][:login], params[:user][:password])
      if user
        session[:user] = user.id
        flash[:notice] = "Login successful"
        redirect_to :controller => 'user', :action => 'home'
      else
        flash[:error] = "Login unsuccessful"
        redirect_to :controller => 'home'
      end
    end
  end

  def logout
    session[:user] = nil
    flash[:notice] = 'Logged out'
    redirect_to :controller => 'home', :action => 'index'
  end
end
