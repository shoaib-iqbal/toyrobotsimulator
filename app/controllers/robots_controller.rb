class RobotsController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :load_or_find_robot_tabletop, only: :place
    before_action :find_robot_tabletop, :check_bot_placement, except: :place
  
    def place
      x, y, facing = params[:command].split(',')
      facing = facing.upcase
      if @robot_tabletop.place(x.to_i, y.to_i, facing)
        render plain: "Placed at (#{x},#{y}) facing #{facing}"
      else
        render plain: "Invalid PLACE command"
      end
    end
  
    def move
      @result = @robot_tabletop.move
      respond_to_command { @result }
    end
  
    def left
      @result = @robot_tabletop.left
      respond_to_command { @result }
    end
  
    def right
      @result = @robot_tabletop.right
      respond_to_command { @result }
    end
  
    def report
      @result = @robot_tabletop.report
      respond_to_command { @result }
    end
  
    private
  
    def check_bot_placement
      render plain: "Robot not placed yet" if @robot_tabletop.nil?
    end

    def load_or_find_robot_tabletop
        @robot_tabletop = RobotTabletop.first || RobotTabletop.new
    end

    def find_robot_tabletop
        @robot_tabletop = RobotTabletop.first
    end
  
    def respond_to_command
      if yield
        render plain: @result
      else
        render plain: "Robot not placed yet"
      end
    end
  end
  