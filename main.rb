require_relative 'lib/app'
require_relative 'lib/command'
require_relative 'lib/arena'
require_relative 'lib/robot'
require_relative 'lib/position'
require_relative 'lib/null_position'

table = Arena.new 5, 5
robot = Robot.new arena: table
App.new(robot).main
