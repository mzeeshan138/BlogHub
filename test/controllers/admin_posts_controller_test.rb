require "test_helper"
require "securerandom"

class AdminPostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = User.create!(
      name: "Admin User",
      email: "admin-#{SecureRandom.hex(8)}@example.com",
      password: "password",
      password_confirmation: "password",
      role: :admin
    )
    @post = Post.create!(
      title: "Managed post #{SecureRandom.hex(8)}",
      description: "Post description",
      user: @admin,
      published: true
    )

    sign_in @admin
  end

  test "manage posts includes show and edit actions" do
    get admin_posts_path

    assert_response :success
    assert_select ".admin-content"
    assert_select "a[href='#{admin_post_path(@post)}']", text: "Show"
    assert_select "a[href='#{admin_edit_post_path(@post)}']", text: "Edit"
  end

  test "toggling publication from manage posts replaces the post row" do
    patch admin_toggle_published_post_path(@post), headers: { "Accept" => "text/vnd.turbo-stream.html" }

    assert_response :success
    assert_equal false, @post.reload.published?
    assert_includes response.body, "replace"
    assert_includes response.body, "manage_post_#{@post.id}"
    assert_includes response.body, "Publish"
    assert_includes response.body, "Draft"
  end

  test "show displays the post with edit and admin back actions" do
    get admin_post_path(@post)

    assert_response :success
    assert_select ".admin-content h1", text: @post.title
    assert_select ".admin-content a[href='#{admin_edit_post_path(@post)}']", text: "Edit"
    assert_select ".admin-content form[action='#{admin_post_path(@post)}'] button", text: "Delete"
    assert_select ".admin-content a[href='#{admin_posts_path}']", text: "Back to manage posts"
  end

  test "edit displays the post form in admin content" do
    get admin_edit_post_path(@post)

    assert_response :success
    assert_select ".admin-content h1", text: "Edit post"
    assert_select ".admin-content form[action='#{admin_post_path(@post)}'][method='post']"
    assert_select ".admin-content input[name='post[title]']"
  end

  test "new displays the post form in admin content" do
    get admin_new_post_path

    assert_response :success
    assert_select ".admin-content h1", text: "New post"
    assert_select ".admin-content form[action='#{admin_posts_path}'][method='post']"
    assert_select ".admin-content input[name='post[title]'].form-control.w-100"
  end
end
