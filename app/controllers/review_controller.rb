class ReviewController < ApplicationController
  def create
    # The instance variable @review is populated with the content of the review form.
    @review = Review.new(params[:review])
    @review.user = User.find(session[:user])
    if !@review.save
      # render error message using RJS
    end
    @book = Book.find(@review.book_id)
  end
end
