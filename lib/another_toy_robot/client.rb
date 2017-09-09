require "another_toy_robot/arena"
require "another_toy_robot/robot"
require "another_toy_robot/command_delegator"

class Client
  def initialize
    @robot = Robot.new
    @table = Arena.new width: 5, height: 5

    @robot.arena = @table
  end

  def command_for(input_obj)
    CommandDelegator.build(basename: input_obj.basename,
                           params:   input_obj.params,
                           robot:    @robot).execute
  end
end
