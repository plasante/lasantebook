class Cd < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :reviews
  acts_as_taggable
  acts_as_rateable
  
  attr_accessor :exists

  def Cd.search_amazon(keyword, page, user_id)
      search = AmazonInterface.new
      results = search.find_by_keyword(keyword, page, 'Music')
      return Cd.convert_amazon_results(results, user_id)
  end

  def Cd.find_or_create_from_amazon(isbn, user_id)
      cd = Cd.find_or_create_by_isbn(isbn)
      if cd.title
          cd.users << User.find(user_id)
      else
          search = AmazonInterface.new
          cds = search.find_by_isbn(isbn)
          cd.set_from_amazon_result(cds[0])
          cd.users << User.find(user_id)
      end 
      return cd
  end
  
  def Cd.convert_amazon_results(results, user_id)
      user = User.find(user_id)
      converted_cds = Array.new
      results.each do |result|
          cd = user.cds.find_by_isbn(result.asin.to_s)
          if (cd) 
              cd.exists = true  # don't need this line
          else
              cd = Cd.new
              cd.exists = false
          end          
          cd.set_from_amazon_result(result)
          converted_cds.push(cd)
      end
      return converted_cds
  end

  def set_from_amazon_result(result)
      self.title = result.item_attributes.title.to_s
      self.author = result.item_attributes[0].author.join(',') unless !result.item_attributes[0].author
      self.release_date = result.item_attributes[0].publication_date.to_s

      if result.small_image
        self.image_url_small = result.small_image.url.to_s
      end
      if result.medium_image
        self.image_url_medium = result.medium_image.url.to_s
      end
      if result.large_image
        self.image_url_large = result.large_image.url.to_s
      end
        
      self.isbn = result.asin.to_s
      self.amazon_url = result.detail_page_url.to_s
  end
  
  def after_find
    self.exists = true
  end
  
  protected
  
  def self.number_of_cds_exceeded?
    num = Cd.find_by_sql("select count(*) as number from cds")[0].number.to_i
    if num > 100
      true
    else
      false
    end
  end
end
