require "toy_robot/version"
require "pry"

module ToyRobot
  def self.sanitize(str)
    str.downcase.strip
  end

  def main
    loop do
      puts "Enter command:"
      command = sanitize(gets)
      command == "exit" ? break : command
    end
  end
end
