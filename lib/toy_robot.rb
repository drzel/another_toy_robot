require "pry"
require "toy_robot/client"
require "toy_robot/robot"
require "toy_robot/arena"
require "toy_robot/command"
require "toy_robot/position"
require "toy_robot/direction"

module ToyRobot
  def self.main
    client = Client.new

    loop do
      command = get_input
      break if command == "exit"
      client.instruction command
    end
  end

  private

  def self.get_input
    print "Input command: "
    gets.downcase.strip
  end
end
