# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def logged_in
    session[:user]? true : false
  end
end
