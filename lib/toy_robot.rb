require "pry"
require "toy_robot/client"
require "toy_robot/robot"
require "toy_robot/arena"
require "toy_robot/command"
require "toy_robot/position"

module ToyRobot
  def self.main
    client = Client.new

    loop do
      print "Input command: "
      input = gets.strip
      break if input == "exit"
      client.instruction input
    end
  end
end
