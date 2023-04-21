require "test_helper"

class FollowTest < ActiveSupport::TestCase
  def setup
    @follower = users(:user_1)
    @following_user = users(:user_2)
    Follow.destroy_all
    @follow = Follow.new(follower: @follower, following_user: @following_user)
  end

  test "should be valid with valid attributes" do
    assert @follow.valid?
  end

  test "should not be valid with duplicate follower and following_user" do
    follow_dup = @follow.dup
    @follow.save
    assert_not follow_dup.valid?
  end

  test "should not be valid if follower_id and following_user_id are the same" do
    @follow.follower = @following_user
    @follow.following_user = @following_user
    assert_not @follow.valid?
  end
end
