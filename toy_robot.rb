require "pry"
require_relative "lib/command"
require_relative "lib/robot"
require_relative "lib/arena"
require_relative "lib/null_arena"
require_relative "lib/position"
require_relative "lib/real_position"
require_relative "lib/null_position"

robot = Robot.new
table = Arena.new 5, 5

loop do
  print "Input command: "
  Command.new(robot, table, gets).execute
end
