require "another_toy_robot/client"
require "another_toy_robot/input"

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
