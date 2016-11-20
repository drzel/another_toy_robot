require "toy_robot/version"
require "pry"

class Robot
  attr_accessor :position

  def initialize
    @position = nil
  end
end

class Tabletop
  def initialize(width, height)
    @width = width
    @height = height
  end

  def valid_position?(position)
    position.x.between?(0, @width - 1) && position.y.between?(0, @height - 1)
  end
end

class Direction
  CARDINAL_POINTS = %w(n e s w)
  NAVIGATE = { left: -1, right: 1, 180: 2 }

  def initialize(char)
    @cardinal_int = CARDINAL_POINTS.find_index char
  end

  def turn(direction)
    Direction.new CARDINAL_POINTS[@cardinal_int + NAVIGATE[direction] % 4]
  end

  def to_s
    CARDINAL_POINTS.find_index(@cardinal_int)
  end
end

class Position
  attr_reader :x, :y

  def initialize(x, y, direction)
    @x = x
    @y = y
    @direction = Direction.new direction
  end

  def direction
    @direction.to_s
  end
end

class Client
  def initialize(robot, tabletop)
    @robot = robot
    @tabletop = tabletop
  end

  def main
    loop do
      puts "Enter command:"
      parse gets
    end
  end

  def parse(command)
    case command
    when /place\s+(\d,\s*){2}[nesw]\s*/
      params = command[/\s.*/].delete(" ").split(",")
      x, y, direction = params[0], params[1], params[2]
      position = Position.new x, y, direction
      PlaceCommand.new(@robot, @tabletop, position).execute
    when "move"
      # MoveCommand.new(@robot).execute
    when "left"
      # LeftCommand.new(@robot)).execute
    when "right"
      # RightCommand.new(@robot).execute
    else
      # error
    end
  end
end

class PlaceCommand
  def initialize(robot, table, position)
    @robot = robot
    @table = table
    @position = position
  end

  def execute
    @robot.position = @position if @table.valid_position?(@position)
  end
end 

class MoveCommand
  def initialize(robot, tabletop)
    @robot = robot
    @tabletop = tabletop
  end

  def execute
  end
end

class LeftCommand
  def initialize(robot)
    @robot = robot
  end

  @robot.position = Position.new(@robot).turn_left
end

class RightCommand
  def initialize(robot)
    @robot = robot
  end

  @robot.position = Position.new(@robot).turn_left
end

