require 'test_helper'

class UesrTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Taro", email: "taro@example.com", password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be presence" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "name should be less than 30 characters" do
    @user.name = "a"*31
    assert_not @user.valid?
  end

  test "email should be presence" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a"*245 + "@example.com"
    assert_not @user.valid?
  end

  test "email should be accept correct format" do
    valid_emails = %w[user@example.com first@yahoo.co]
    valid_emails.each do |valids|
      @user.email = valids
      assert @user.valid?, "#{valids.inspect} should be valid"
    end
  end

  test "email should be unique and case insensitive" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be case before hitting db" do
    mixed_email = 'taro@Example.com'
    @user.save
    assert_equal mixed_email.downcase, @user.reload.email
  end
end
