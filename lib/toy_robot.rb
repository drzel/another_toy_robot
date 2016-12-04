require "pry"
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

module ToyRobot
  def self.main
    client = Client.new

    loop do
      print "Input command: "
      input = gets
      break if input =~ /^\s*exit\s+/
      client.command_for Input.new(input)
    end
  end
end
