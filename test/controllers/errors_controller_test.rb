require "test_helper"

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test "unmatched routes render the not found page" do
    get "/a-route-that-does-not-exist"

    assert_response :not_found
    assert_select "h1", "Page not found"
    assert_select "a[href='#{root_path}']", "Back to BlogHub"
  end
end
