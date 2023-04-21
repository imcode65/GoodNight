require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user    = users(:user_1)
    @user2   = users(:user_2)
    @user3   = users(:user_3)
  end

  test "should get index" do
    get users_url, as: :json
    assert_response :success
  end

  test "should get index for user's followings" do
    get users_url(view: 'followings', user_id: @user.id), as: :json
    assert_response :success
    response_body = JSON.parse(response.body)
    assert_includes response_body['data'], { id: @user2.id, name: @user2.name, sleeps: 0, followers: 1, followings: 0 }.as_json
    assert_includes response_body['data'], { id: @user3.id, name: @user3.name, sleeps: 0, followers: 1, followings: 0 }.as_json
  end

  test "should get index for user's followers" do
    get users_url(view: 'followers', user_id: @user2.id), as: :json
    assert_response :success
    response_body = JSON.parse(response.body)
    assert_includes response_body['data'], { id: @user.id, name: @user.name, sleeps: 1, followers: 0, followings: 2 }.as_json
  end
end
