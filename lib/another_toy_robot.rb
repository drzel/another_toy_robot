require "another_toy_robot/client"
require "another_toy_robot/input"

module AnotherToyRobot
  def self.main
    client = Client.new

    loop do
      print "Input command: "
      input = Input.new gets

      client.command_for input
    end
  end
end
