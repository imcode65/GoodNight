require "test_helper"

class Users::FollowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user           = users(:user_1)
    @following_user = users(:user_2)
  end

  test "should get index" do
    get user_follows_url(@user), as: :json
    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal @user.followers.count, response_body["followers"]
    assert_equal @user.followings.count, response_body["followings"]
    assert_equal @user.sleeps.count, response_body["sleeps"]
  end

  test "should create follow" do
    assert_difference('@user.followings.count', 1) do
      post user_follows_url(@user), params: { following_user_id: users(:user_3).id }, as: :json
    end

    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal "You started following #{users(:user_3).name}", response_body["message"]
  end

  test "should not create follow if invalid following_user_id is provided" do
    assert_no_difference('@user.followings.count') do
      post user_follows_url(@user), params: { following_user_id: nil }, as: :json
    end

    assert_response :unprocessable_entity
    response_body = JSON.parse(response.body)
    assert_equal true, response_body["error"]
    assert_equal ["must exist"], response_body['message']&.[]('following_user')
  end

  test "should destroy follow" do
    assert_difference('@user.followings.count', -1) do
      delete user_follow_url(@user, @user.given_follows.find_by(following_user: @following_user).following_user_id), as: :json
    end

    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal "You have unfollowed #{users(:user_2).name}", response_body["message"]
  end

  test "should not destroy follow if follow does not exist" do
    assert_no_difference('@user.followings.count') do
      delete user_follow_url(@user, users(:user_3).id), as: :json
    end

    assert_response :not_found
    response_body = JSON.parse(response.body)
    assert_equal true, response_body["error"]
    assert_equal "Can't unfollow a non-following user", response_body['message']
  end

  test "should not destroy follow if user does not exist" do
    assert_no_difference('@user.followings.count') do
      delete user_follow_url(SecureRandom.uuid, @following_user.id), as: :json
    end

    assert_response :not_found
    response_body = JSON.parse(response.body)
    assert_equal true, response_body["error"]
    assert_equal "User not found!", response_body["message"]
  end
end

