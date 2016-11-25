require "pry"
require "./lib/toy_robot/version"
require "./lib/toy_robot/client"
require "./lib/toy_robot/robot"
require "./lib/toy_robot/arena"
require "./lib/toy_robot/command"
require "./lib/toy_robot/position"

robot = Robot.new
table = Arena.new width: 5, height: 5

loop do
  print "Input command: "
  command = Client.new robot: robot, arena: table, command: gets
  command.execute
end
