require "another_toy_robot/move_command"
require "another_toy_robot/left_command"
require "another_toy_robot/right_command"
require "another_toy_robot/place_command"
require "another_toy_robot/report_command"
require "another_toy_robot/invalid_command"

class Input
  def initialize(input)
    @input = input.strip.downcase
  end

  def new_command(target)
    command_class.new target: target, params: params
  end

  private

  def params
    @params ||= @input.split(" ").drop 1
  end

  def basename
    @basename ||= @input.split(" ").first
  end

  def command_class
    klass = "#{basename.capitalize}Command"
    return InvalidCommand unless Object.const_defined? klass
    Object.const_get klass
  end
end
