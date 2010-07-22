class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates_presence_of :body, :title, :user_id, :book_id
end
