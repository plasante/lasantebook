class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  belongs_to :cd
  belongs_to :dvd

  validates_presence_of :body, :title, :user_id
  
  protected
  
  def self.number_of_reviews_exceeded?
    num = Review.find_by_sql("select count(*) as number from reviews")[0].number.to_i
    if num > 500
      true
    else
      false
    end
  end
end
