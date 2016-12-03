require "pry"
require "toy_robot/client"
require "toy_robot/robot"
require "toy_robot/arena"
require "toy_robot/command"
require "toy_robot/direction"
require "toy_robot/position"
require "toy_robot/null_position"
require "toy_robot/input"

module ToyRobot
  def self.main
    client = Client.new

    loop do
      print "Input command: "
      input = gets
      break if input.chomp == "exit"
      client.command_for Input.new(input)
    end
  end
end
