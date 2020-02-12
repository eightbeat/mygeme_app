require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "taro", email: "taro@example.com", password: "password", password_confirmation: "password")
    @admin_user = User.create!(name: "hanako", email: "hanako@example.com",
              password:"password", password_confirmation: "password", admin: true)
    @user2 = User.create!(name: "jiro", email: "jiro@example.com", password: "password", password_confirmation: "password")
  end

  test "reject an invalid edit" do
    sign_in_as(@user, "password")
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: " ", email: " " } }
    assert_template 'users/edit'
  end

  test "accept valid edit" do
    sign_in_as(@user, "password")
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "taro1", email: "taro1@example.com"} }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match "taro1", @user.name
    assert_match "taro1@example.com", @user.email
  end

  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: { name: "roku", email: "roku@example.com" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match "roku", @user.name
    assert_match "roku@example.com", @user.email
  end

  test "redirect edit attempt by another nonadmin user" do
    sign_in_as(@user2, "password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch user_path(@user), params: { user: { name: updated_name,
                                  email: updated_email } }
    assert_redirected_to users_path
    assert_not flash.empty?
    @user.reload
    assert_match "taro", @user.name
    assert_match "taro@example.com", @user.email
  end
end
