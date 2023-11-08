require "test_helper"

class RobotTabletopTest < ActiveSupport::TestCase
  def setup
    @robot = RobotTabletop.new
  end

  test "place method success case" do
    assert_equal true, @robot.place(1, 2, 'NORTH')
  end

  test "place method failure case" do
    assert_equal false, @robot.place(6, 2, 'NORTH')
  end

  test "move method success case" do
    @robot.place(1, 2, 'NORTH')
    assert_equal "Current position: (1,3), facing NORTH", @robot.move
  end

  test "move method failure case (not placed)" do
    assert_equal false, @robot.move
  end

  test "left method success case" do
    @robot.place(1, 2, 'NORTH')
    assert_equal "Current position: (1,2), facing WEST", @robot.left
  end

  test "left method failure case (not placed)" do
    assert_equal false, @robot.left
  end

  test "right method success case" do
    @robot.place(1, 2, 'NORTH')
    assert_equal "Current position: (1,2), facing EAST", @robot.right
  end

  test "right method failure case (not placed)" do
    assert_equal false, @robot.right
  end

  test "report method success case" do
    @robot.place(1, 2, 'NORTH')
    assert_equal "Current position: (1,2), facing NORTH", @robot.report
  end

  test "report method failure case (not placed)" do
    assert_equal "Robot not placed yet", @robot.report
  end
end
