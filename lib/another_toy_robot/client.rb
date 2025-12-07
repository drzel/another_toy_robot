# frozen_string_literal: true

require "another_toy_robot/arena"
require "another_toy_robot/robot"

class Client
  def initialize
    @table = Arena.new width: 5, height: 5
    @robot = Robot.new arena: @table
  end

  def command_for(input)
    klass   = input.to_class
    params  = input.params
    command = klass.new target: @robot, params: params

    command.execute
  end
end
