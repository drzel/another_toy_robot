require "toy_robot/client"
require "toy_robot/input"
require "toy_robot/robot"
require "toy_robot/arena"
require "toy_robot/command"
require "toy_robot/direction"
require "toy_robot/position"
require "toy_robot/null_position"
require "toy_robot/invalid_command.rb"
require "toy_robot/left_command.rb"
require "toy_robot/move_command.rb"
require "toy_robot/place_command.rb"
require "toy_robot/report_command.rb"
require "toy_robot/right_command.rb"

class Input
  def initialize(input)
    @input = input.strip.downcase.split " "
  end

  def basename
    @basename ||= @input.first
  end

  def params
    @params ||= @input.drop 1
  end

  def classname
    @classname ||= "#{basename.capitalize}Command"
  end

  def to_class
    if Object.const_defined? classname
      Object.const_get classname
    else
      InvalidCommand
    end
  end

  def new_command(target:)
    to_class.new target: target, params: params
  end
end
