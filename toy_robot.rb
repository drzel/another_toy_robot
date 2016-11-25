require "pry"
require "./lib/toy_robot/version"
require "./lib/toy_robot/client"
require "./lib/toy_robot/robot"
require "./lib/toy_robot/arena"
require "./lib/toy_robot/command"
require "./lib/toy_robot/position"

client = Client.new

loop do
  print "Input command: "
  client.instruction gets
end
