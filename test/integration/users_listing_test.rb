require 'test_helper'

class UsersListingTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "taro", email: "taro@example.com",
        password: "password", password_confirmation: "password")
    @user2 = User.create!(name: "jiro", email: "jiro@example.com",
            password: "password", password_confirmation: "password")
  end

  test "should get listing" do
    get users_path
    assert_template 'users/index'
    assert_select "a[href=?]", user_path(@user), text: @user.name.capitalize
    assert_select "a[href=?]", user_path(@user2), text: @user2.name.capitalize
  end

  test "should delete user" do
    get users_path
    assert_template 'users/index'
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
    assert_redirected_to users_path
    assert_not flash.empty?
  end

  test "associated games should be destroyed" do
    @user.save
    @user.games.create!(name: "test", description: "test description", score: 5)
    assert_difference 'Game.count', -1 do
      @user.destroy
    end
  end
end
