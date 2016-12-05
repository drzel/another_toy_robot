require "another_toy_robot/command"

class InvalidCommand < Command
  def execute
    puts "Invalid command"
  end
end
