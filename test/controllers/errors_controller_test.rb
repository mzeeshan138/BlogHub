require "test_helper"

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test "unmatched routes render the not found page" do
    get "/a-route-that-does-not-exist"

    assert_response :not_found
    assert_select "h1", "Page not found"
    assert_select "a[href='#{root_path}']", "Back to BlogHub"
  end

  test "unmatched asset-like routes do not raise a missing template error" do
    get "/a-route-that-does-not-exist.jpg", headers: { "Accept" => "image/jpeg" }

    assert_response :not_found
  end

  test "active storage routes are not handled by the application 404 page" do
    route = Rails.application.routes.recognize_path(
      "/rails/active_storage/blobs/redirect/signed-id/image.jpg"
    )

    assert_not_equal "errors", route[:controller]
  end
end
