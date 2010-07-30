class ReviewController < ApplicationController
  def create
    # The instance variable @review is populated with the content of the review form.
    @item = params[:item_type]
    @review = Review.new(params[:review])
    @review.user = User.find(session[:user])
    if Review.number_of_reviews_exceeded?
      render :text => 'Number of reviews is exceeded'
    else
      if !@review.save
        # render error message using RJS
      end
    end
    if @review.book_id
      @book = Book.find(@review.book_id)
    elsif @review.cd_id
      @book = Cd.find(@review.cd_id)
    else
      @book = Dvd.find(@review.dvd_id)
    end
  end
end
