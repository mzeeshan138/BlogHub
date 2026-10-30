require "test_helper"
require "securerandom"

class AdminUsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = User.create!(
      name: "Admin User",
      email: "admin-#{SecureRandom.hex(8)}@example.com",
      password: "password",
      password_confirmation: "password",
      role: :admin
    )
    @user = User.create!(
      name: "Blog User",
      email: "user-#{SecureRandom.hex(8)}@example.com",
      password: "password",
      password_confirmation: "password",
      role: :user
    )

    sign_in @admin
  end

  test "manage users includes show and edit actions" do
    get admin_users_path

    assert_response :success
    assert_select ".admin-content"
    assert_select "a[href='#{admin_user_path(@user)}']", text: "Show"
    assert_select "a[href='#{edit_admin_user_path(@user)}']", text: "Edit"
  end

  test "show displays the user profile and edit action in admin content" do
    get admin_user_path(@user)

    assert_response :success
    assert_select ".admin-content h1", text: @user.name
    assert_select ".admin-content", text: /#{Regexp.escape(@user.email)}/
    assert_select ".admin-content a[href='#{edit_admin_user_path(@user)}']", text: "Edit"
  end

  test "edit displays the user form in admin content" do
    get edit_admin_user_path(@user)

    assert_response :success
    assert_select ".admin-content h1", text: "Edit user"
    assert_select ".admin-content form[action='#{admin_user_path(@user)}'][method='post']"
    assert_select ".admin-content input[name='user[name]']"
    assert_select ".admin-content input[name='user[email]']"
  end
end
