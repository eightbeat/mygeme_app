require 'test_helper'

class GameTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(name: "taro", email: "taro@example.com", password: "password", password_confirmation: "password")
    @game = @user.games.build(name: "mario", description: "nice game", score: 10)
  end

  test "game should be valid" do
    assert @game.valid?
  end

  test "name should be present" do
    @game.name = " "
    assert_not @game.valid?
  end

  test "description should be present" do
    @game.description = " "
    assert_not @game.valid?
  end

  test "description should not be less than 3 characters" do
    @game.description = "a"*3
    assert_not @game.valid?
  end

  test "description should not be more than 501 characters" do
    @game.description = "a"*501
    assert_not @game.valid?
  end
end
