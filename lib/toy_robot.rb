require "pry"

class Robot
  def initialize(arena:, position: NullPosition.new)
    @arena = arena
    @position = position
  end

  def place(position)
    go_to position
  end

  def move
    go_to @position.advance
  end

  def left
    @position = @position.turn :left
  end

  def right
    @position = @position.turn :right
  end

  def report
    puts @position.to_s
  end

  private

  def go_to(position)
    @position = position if position.inside? @arena.max_x, @arena.max_y
  end
end

class Arena
  attr_reader :max_x, :max_y

  def initialize(width, height)
    @max_x = width - 1
    @max_y = height - 1
  end
end

class Position
  COMPASS      = %i(n e s w).freeze
  ROTATION     = { left: -1, right: 1 }.freeze
  DISPLACEMENT = { n: { x: 0,  y: 1  },
                   e: { x: 1,  y: 0  },
                   s: { x: 0,  y: -1 },
                   w: { x: -1, y: 0  } }.freeze

  def initialize(x:, y:, direction:)
    @x         = x
    @y         = y
    @direction = direction
  end

  def advance
    displacement = DISPLACEMENT[@direction]
    new_x        = @x + displacement[:x]
    new_y        = @y + displacement[:y]
    Position.new x: new_x, y: new_y, direction: @direction
  end

  def turn(hand_side)
    index = (COMPASS.find_index(@direction) + ROTATION[hand_side]) % 4
    Position.new x: @x, y: @y, direction: COMPASS[index]
  end

  def inside?(x, y)
    @x.between?(0, x) && @y.between?(0, y)
  end

  def to_s
    "#{@x}, #{@y}, #{@direction}"
  end
end

class NullPosition
  def advance
    self
  end

  def turn(*)
    self
  end

  def to_s
    "no position"
  end

  def inside?(*)
    false
  end
end

class Command
  def initialize(robot, command)
    @robot = robot
    @command = command.strip
  end

  def execute
    case @command
    when /place\s+(\d,\s*){2}[nesw]/ then @robot.place place_position
    when "move"                      then @robot.move
    when "left"                      then @robot.left
    when "right"                     then @robot.right
    when "report"                    then @robot.report
    else                             puts "invalid command"
    end
  end

  def place_position
    params = @command[/\s.*/].delete(" ").split(",")
    Position.new(x:         params[0].to_i,
                 y:         params[1].to_i,
                 direction: params[2].to_sym)
  end
end

class Client
  def initialize
    @tabletop = Arena.new 5, 5
    @robot = Robot.new arena: @tabletop
  end

  def main
    loop do
      print "Input command: "
      Command.new(@robot, gets).execute
      puts
    end
  end
end

Client.new.main
