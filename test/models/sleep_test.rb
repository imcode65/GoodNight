require "test_helper"

class SleepTest < ActiveSupport::TestCase
  def setup
    @user = User.first
    @sleep = Sleep.new(start_time: Time.now - 7.hour, end_time: Time.now, user: @user)
  end

  test "should be valid with valid attributes" do
    assert @sleep.valid?
  end

  test "should not be valid without a start time" do
    @sleep.start_time = nil
    assert_not @sleep.valid?
  end

  test "should not be valid without an end time" do
    @sleep.end_time = nil
    assert_not @sleep.valid?
  end

  test "should not be valid with a start time greater than end time" do
    @sleep.start_time = Time.now
    @sleep.end_time = Time.now - 1.hour
    assert_not @sleep.valid?
  end
end
