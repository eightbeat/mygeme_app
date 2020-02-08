require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "Taro", email: "Taro@example.com", password: "password", password_confirmation: "password")
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
end
