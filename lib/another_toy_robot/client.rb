require "another_toy_robot/arena"
require "another_toy_robot/robot"

class Client
  def initialize
    @robot = Robot.new
    @table = Arena.new width: 5, height: 5

    @robot.arena = @table
  end

  def command_for(input)
    input.new_command(@robot).execute
  end
end
