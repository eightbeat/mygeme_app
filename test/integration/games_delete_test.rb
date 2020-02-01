require 'test_helper'

class GamesDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "Taro", email: "Taro@example.com", password: "password", password_confirmation: "password")
    @game = Game.create!(name: "Mario", description: "This is a first videogame in the world", score: 10, user: @user)
  end

  test "successfully delete a game" do
    get game_path(@game)
    assert_template 'games/show'
    assert_select 'a[href=?]', game_path(@game), text: "レビューを削除する"
    assert_difference 'Game.count', -1 do
      delete game_path(@game)
    end
    assert_redirected_to games_path
    assert_not flash.empty?
  end
end
