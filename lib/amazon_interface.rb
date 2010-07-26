require 'amazon/aws'
require 'amazon/aws/search'

class AmazonInterface

  # don't want to have fully qualified identifiers
  include Amazon::AWS
  include Amazon::AWS::Search
  
  ASSOCIATES_ID = "lasbooshe-20"
  DEV_TOKEN     = "AKIAJN3CY7PUTCYGV7PQ"
  
  def initialize
    @request = Request.new(DEV_TOKEN, ASSOCIATES_ID, 'ca', false)
    @request.config['secret_key_id'] = 'OwUEcpGzl5iHd7QS9TVdcHj8sVaK7SBCy+KtPAjk'
  end
  
  def find_by_isbn(isbn)
    il = ItemLookup.new( 'ASIN', { 'ItemId' => isbn } )
    rg = ResponseGroup.new('Medium')
    resp = @request.search(il)
    products = resp.item_lookup_response.items.item
  end
  
  
  def find_by_keyword(keyword, page, item = 'Books')
    is = ItemSearch.new(item, {'Keywords' => keyword, 'ItemPage' => page })
    rg = ResponseGroup.new('Medium')
    resp = @request.search(is)
    products = resp.item_search_response.items.item
  end

  def after_find
    self.exists = true
  end
end
