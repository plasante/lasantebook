class ReviewController < ApplicationController
  def create
    # The instance variable @review is populated with the content of the review form.
    @review = Review.new(params[:review])
    @review.user = User.find(session[:user])
    if Review.number_of_reviews_exceeded?
      render :text => 'Number of books is exceeded'
    else
      if !@review.save
        # render error message using RJS
      end
    end
    @book = Book.find(@review.book_id)
  end
end
