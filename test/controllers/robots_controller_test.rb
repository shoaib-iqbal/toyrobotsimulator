require "test_helper"

class RobotsControllerTest < ActionController::TestCase
  test "should place robot successfully" do
    post :place, params: { command: "1,2,NORTH" }
    assert_equal "Placed at (1,2) facing NORTH", @response.body
  end

  test "should not place robot with invalid command" do
    post :place, params: { command: "1,2,INVALID" }
    assert_equal "Invalid PLACE command", @response.body
  end

  test "should move robot successfully" do
    # RobotTabletop.create(x: 1, y: 1, facing: "NORTH")
    post :move
    assert_equal "Current position: (1,2), facing NORTH", @response.body
  end

  test "should turn robot left successfully" do
    post :left
    assert_equal "Current position: (1,1), facing WEST", @response.body
  end

  test "should turn robot right successfully" do
    post :right
    assert_equal "Current position: (1,1), facing EAST", @response.body
  end

  test "should report robot position successfully" do
    post :report
    assert_equal "Current position: (1,1), facing NORTH", @response.body
  end
end
