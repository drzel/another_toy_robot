require "toy_robot/version"
require "pry"

class Robot
  attr_accessor :position

  def initialize
    @position = nil
  end

  def report
    @position.to_s
  end
end

class Tabletop
  def initialize(width, height)
    @width = width
    @height = height
  end

  def valid_position?(x, y)
    x.between?(0, @width - 1) && y.between?(0, @height - 1)
  end
end

class Direction
  CARDINAL_POINTS = %i(n e s w).freeze

  attr_reader :cardinal_point

  def initialize(cardinal_point)
    @cardinal_point = cardinal_point
  end

  def left
    Direction.new CARDINAL_POINTS[(to_i - 1) % 4]
  end

  def right
    Direction.new CARDINAL_POINTS[(to_i + 1) % 4]
  end

  def to_i
    CARDINAL_POINTS.find_index(@cardinal_point)
  end

  def to_s
    @cardinal_point.to_s
  end
end

class Position
  DISPLACEMENT = {
    n: { x: 0, y: 1 },
    e: { x: 1, y: 0 },
    s: { x: 0, y: -1 },
    w: { x: -1, y: 0 },
  }.freeze

  attr_reader :x, :y

  def initialize(x, y, direction)
    @x = x
    @y = y
    @direction = direction
  end

  def step
    displacement = DISPLACEMENT[@direction.cardinal_point]
    new_x = @x + displacement[:x]
    new_y = @y + displacement[:y]
    Position.new new_x, new_y, @direction
  end

  def turn_left
    Position.new @x, @y, @direction.left
  end

  def turn_right
    Position.new @x, @y, @direction.right
  end

  def to_s
    "#{@x}, #{@y}, #{@direction}"
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
      x = params[0]
      y = params[1]
      direction = params[2]
      position = Position.new x, y, direction
      PlaceCommand.new(@robot, @tabletop, position).execute
    when "move"
      MoveCommand.new(@robot, @tabletop).execute
    when "left"
      LeftCommand.new(@robot).execute
    when "right"
      RightCommand.new(@robot).execute
    when "report"
      ReportCommand.new(@robot).execute
    else
      # error
    end
  end
end

class PlaceCommand
  def initialize(robot, tabletop, position)
    @robot = robot
    @tabletop = tabletop
    @position = position
  end

  def execute
    @robot.position = @position if @tabletop.valid_position?(@position.x, @position.y)
  end
end

class MoveCommand
  def initialize(robot, tabletop)
    @robot = robot
    @tabletop = tabletop
  end

  def execute
    new_position = @position.step
    if @tabletop.valid_position? new_position.x, new_position.y
      @robot.position = new_position
    end
  end
end

class LeftCommand
  def initialize(robot)
    @robot = robot
  end

  def execute
    @robot.position = @robot.position.turn_left
  end
end

class RightCommand
  def initialize(robot)
    @robot = robot
  end

  def execute
    @robot.position = @robot.position.turn_right
  end
end

class ReportCommand
  def initialize(robot)
    @robot = robot
  end

  def execute
    puts @robot.report
  end
end
