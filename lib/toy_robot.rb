require "pry"
require "toy_robot/client"
require "toy_robot/robot"
require "toy_robot/arena"
require "toy_robot/command"
require "toy_robot/position"

client = Client.new

loop do
  print "Input command: "
  input = gets.strip
  client.instruction input
end
