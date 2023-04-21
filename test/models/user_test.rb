require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:user_1)
    @other_user = users(:user_2)
  end

  test "should have followers" do
    assert @other_user.followers.include?(@user)
  end

  test "should have followings" do
    assert @user.followings.include?(@other_user)
  end

  test "should have sleeps" do
    assert @user.sleeps.any?
  end
end
