class RatingsController < ApplicationController
  before_filter :get_class_by_name
  
  def rate
    rateable = @rateable_class.find(params[:id])
    # Delete the old ratings for current user
    @current_user = User.find( session[:user] )
    Rating.delete_all(["rateable_type = ? AND rateable_id = ? AND user_id = ?", @rateable_class.base_class.to_s, params[:id], @current_user])
    rateable.add_rating Rating.new(:rating => params[:rating], :user_id => @current_user.id)

    render :update do |page|
          page.replace_html "star-ratings-block-#{rateable.id}", :partial => "book/rate", :locals => { :asset => rateable}
          page.visual_effect :highlight, "star-ratings-block-#{rateable.id}"
    end

  end

  protected

  def get_class_by_name
    bad_class = false
    begin
      @rateable_class = Module.const_get(params[:rateable_type])
    rescue NameError
      bad_class = true
    end

    if bad_class
      redirect_to home_url
      return false
    end
    true
  end
end
