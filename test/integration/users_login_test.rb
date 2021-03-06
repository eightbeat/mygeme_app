require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "Taro", email: "taro@example.com", password: "password")
  end

  test "invalid login is rejected" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {email: " ", password: " "} }
    assert_template 'sessions/new'
    get root_path
    assert flash.empty?
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "valid login credentials accepts and begin session" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {email: "taro@example.com", password: "password"} }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
  end
end
