require "another_toy_robot/arena"
require "another_toy_robot/robot"

class Client
  def initialize
    @robot = Robot.new
    @table = Arena.new width: 5, height: 5

    @robot.arena = @table
  end

  def command_for(input)
    klass   = input.to_class
    params  = input.params
    command = klass.new target: @robot, params: params

    command.execute
  end
end
