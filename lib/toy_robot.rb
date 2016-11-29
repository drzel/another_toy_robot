require "pry"
require "toy_robot/client"
require "toy_robot/robot"
require "toy_robot/arena"
require "toy_robot/command"
require "toy_robot/direction"
require "toy_robot/position"
require "toy_robot/null_position"

module ToyRobot
  def self.main
    client = Client.new

    loop do
      print "Input command: "
      input = get_input
      break if input == "exit"
      client.parse input
    end
  end

  private

  def self.get_input
    gets.downcase.strip
  end
end
