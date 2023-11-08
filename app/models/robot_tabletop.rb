class RobotTabletop < ApplicationRecord

  def place(x, y, facing)
    return false unless valid_position?(x, y, facing)
    update(facing: facing, x: x, y: y)
    true
  end

  def move
    x = self.x
    y = self.y
    facing = self.facing
    return false unless robot_placed?
    case facing
    when 'NORTH'
      y += 1 if valid_position?(x, y + 1, facing)
    when 'SOUTH'
      y -= 1 if valid_position?(x, y - 1, facing)
    when 'EAST'
      x += 1 if valid_position?(x + 1, y, facing)
    when 'WEST'
      x -= 1 if valid_position?(x - 1, y, facing)
    end
    move_flag = check_move ? update_column(:y, y) : update_column(:x, x)
    "Current position: (#{x},#{y}), facing #{facing}"
  end

  def left
    x = self.x
    y = self.y
    facing = self.facing
    return false unless robot_placed?
    case facing
    when 'NORTH' then facing = 'WEST'
    when 'SOUTH' then facing = 'EAST'
    when 'EAST' then  facing = 'NORTH'
    when 'WEST' then  facing = 'SOUTH'
    end
    update_column(:facing, facing)
    "Current position: (#{x},#{y}), facing #{facing}"
  end

  def right
    x = self.x
    y = self.y
    facing = self.facing
    return false unless robot_placed?

    case facing
    when 'NORTH' then facing = 'EAST'
    when 'SOUTH' then facing = 'WEST'
    when 'EAST' then facing = 'SOUTH'
    when 'WEST' then facing = 'NORTH'
    end
    update_column(:facing, facing)
    "Current position: (#{x},#{y}), facing #{facing}"
  end

  def report
    x = self.x
    y = self.y
    facing = self.facing
    return 'Robot not placed yet' unless robot_placed?

    "Current position: (#{x},#{y}), facing #{facing}"
  end
  
  def check_move
    facing == 'NORTH' || facing == 'SOUTH'
  end

  private

  def valid_position?(x, y, facing)
    (0..4).include?(x) && (0..4).include?(y) && %w(NORTH SOUTH EAST WEST).include?(facing)
  end

  def robot_placed?
    !facing.nil?
  end
end
