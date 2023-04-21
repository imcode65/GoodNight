require "test_helper"

class SleepsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @sleep = sleeps(:sleep_1)
  end

  test "should get index" do
    get sleeps_path, as: :json
    assert_response :success
  end

  test "should filter sleeps by date range" do
    get sleeps_path(from: Date.today - 5.days, to: Date.today + 1.days), as: :json
    assert_response :success
    assert_equal User.first.sleeps.where(created_at: (Date.today - 5.days)..(Date.today + 1.days)).count, Sleep.all.count
  end

  test "should get sleep" do
    get sleep_path(@sleep), as: :json
    assert_response :success
  end

  test "should create sleep" do
    assert_difference('Sleep.count') do
      post sleeps_path, params: { start_time: "2023-04-22 23:00:00", end_time: "2023-04-23 07:00:00" }, as: :json
    end
    assert_response :success
  end

  test "should not create invalid sleep" do
    assert_no_difference('Sleep.count') do
      post sleeps_path, params: { start_time: "2023-04-22 23:00:00" }, as: :json
    end
    assert_response :unprocessable_entity
    response = JSON.parse(@response.body)
    assert_equal  true, response['error']
    assert_equal  ["can't be blank"], response['message']&.[]('end_time')
  end

  test "should update sleep" do
    patch sleep_path(@sleep), params: { end_time: "2023-04-23 08:00:00" }, as: :json
    assert_response :success
    assert_equal "2023-04-23 08:00:00", @sleep.reload.end_time.strftime("%Y-%m-%d %H:%M:%S")
  end

  test "should not update invalid sleep" do
    patch sleep_path(@sleep), params: { end_time: "2023-04-22 23:00:00" }, as: :json
    assert_response :unprocessable_entity
    response = JSON.parse(@response.body)
    assert_equal  true, response['error']
    assert_equal  ["Start Time should always be lesser than the End Time"], response['message']&.[]('base')
  end

  test "should destroy sleep" do
    assert_difference('Sleep.count', -1) do
      delete sleep_path(@sleep), as: :json
    end
    assert_response :success
  end

  test "should not destroy non-existent sleep" do
    delete sleep_path(id: "non-existent"), as: :json
    assert_response :not_found
  end
end

