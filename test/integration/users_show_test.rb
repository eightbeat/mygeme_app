require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "taro", email: "taro@example.com",
        password: "password", password_confirmation: "password")
    @game = Game.create!(name: "mario", description: "great game", user: @user, score: 10)
    @game2 = @user.games.build(name: "zelda", description: "bast game", score: 10)
    @game2.save
  end

  test "should show user page" do
    sign_in_as(@user, "password")
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'a[href=?]', game_path(@game),
                              text: @game.name
    assert_select 'a[href=?]', game_path(@game2),
                              text: @game2.name
    assert_match @game.description, response.body
    assert_match @game2.description, response.body
  end
end
