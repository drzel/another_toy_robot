require "toy_robot/version"
require "pry"

class Client
  def main
    loop do
      puts "Enter command:"
      parse gets
    end
  end

  def parse(command)
    case command
    when "move"
      # MoveCommand.new(@robot).execute
    when "left"
      # LeftCommand.new(@robot)).execute
    when "right"
      # RightCommand.new(@robot).execute
    when /place\s*(\d\s*,\s*){2}[nesw]/
      # PlaceCommand.new(@robot).execute
    else
      # error
    end
  end
end

class Tabletop
  def initialize(x, y)
    @width = x
    @height = y
  end
end

class Direction
  CARDINAL_POINTS = %w(NORTH EAST SOUTH WEST).freeze
  NAVIGATE = { left: -1, right: 1 }.freeze

  def initialize(cardinal_point)
    @cardinal_point = cardinal_point
  end

  def turn(direction)
    Direction.new CARDINAL_POINTS[to_i + NAVIGATE[direction]]
  end

  private

  def to_i
    CARDINAL_POINTS.find_index @cardinal_point
  end
end

class Position

  attr_reader :x, :y, :direction

  def initialize(x, y, direction)
    @x = x
    @y = y
    @direction = direction
  end

  def turn_left
    self.direction = DIRECTIONS.find_index(self.direction) - 1
    Position.new @x, @y, direction - 1
  end

  def turn_right
    self.direction = DIRECTIONS.find_index(self.direction) + 1
  end
end

class Robot
  attr_accessor :position

  def initialize
    @position = nil
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

class PlaceCommand
end 
