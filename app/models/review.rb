class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates_presence_of :body, :title, :user_id, :book_id
  
  protected
  
  def self.number_of_reviews_exceeded?
    num = Review.find_by_sql("select count(*) number from reviews")[0].number.to_i
    if num > 500
      true
    else
      false
    end
  end
end
