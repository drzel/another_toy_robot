require "another_toy_robot/client"
require "another_toy_robot/input"

module AnotherToyRobot
  def self.main
    client = Client.new
    clear

    loop do
      print client.map
      print "Input command: "
      input = gets
      break if input =~ /^\s*exit\s+/
      clear
      client.command_for Input.new(input)
    end
  end

  def self.clear
    system("clear") || system("cls")
  end
end
