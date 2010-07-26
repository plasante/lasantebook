require File.dirname(__FILE__) + "/../test_helper"

class BookControllerTest < ActionController::TestCase
  fixtures :books, :users, :reviews
  
  def test_list
    # get post put head delete are available
    # get :list, :id => 1
    # the assigns method looks for an instance variable defined in the controller's action
    # assigns cookies flash session
    get :list
    title = assigns(:title)
    assert_equal "Book Shelf All Books", title
    books = assigns(:books)
    assert_equal 2 , books.size
    assert_response :success
    assert_template "list"
  end

  def test_show
    get :show, {:id => '1'},  {:user => users(:one)} 
    title = assigns(:title)
    assert_equal "Book Detail", title
    assert_response :success
    assert_template "show"
    # To verify that the page rendered contains a div tag with id attribute equals to book_image
    assert_select "div#asset_image"
    assert_select "div#book_summary"
    assert_select "div#book_reviews"
    assert_select "div#reviews" do          # to verify that a div with id reviews has two children with class review
      assert_select "div.review", 2 do
        assert_select "span.review_title"
        assert_select "span.review_user"
        assert_select "span.review_body"
      end
    end
  end
end
