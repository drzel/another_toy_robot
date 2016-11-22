require "pry"

class Robot
  def initialize(arena:, position: NullPosition.new)
    @arena = arena
    @position = position
  end

  def place(position)
    if position.inside? @arena
      @position = position
    end
  end

  def report
    puts @position.to_s
  end

  def turn(direction)
    @position = @position.turn direction
  end

  def move
    place @position.advance
  end
end

Arena = Struct.new(:width, :height) do
end

class Position
  COMPASS      = %i(n e s w).freeze
  ROTATION     = { left: -1, right: 1 }.freeze
  DISPLACEMENT = { n: { x: 0,  y: 1  },
                   e: { x: 1,  y: 0  },
                   s: { x: 0,  y: -1 },
                   w: { x: -1, y: 0  } }.freeze

  def initialize(x:, y:, direction:)
    @x = x
    @y = y
    @direction = direction
  end

  def advance
    displacement = DISPLACEMENT[@direction]
    new_x = @x + displacement[:x]
    new_y = @y + displacement[:y]
    Position.new new_x, new_y, @direction
  end

  def turn(direction)
    index = (COMPASS.find_index @direction + ROTATION[direction]) % 4
    Position.new @x, @y, COMPASS[index]
  end

  def inside?(arena)
    @x.between?(0, arena.width - 1) && @y.between?(0, arena.height - 1)
  end

  def to_s
    "#{@x}, #{@y}, #{@direction}"
  end
end

class NullPosition
  def advance
    NullPosition.new
  end

  def turn(*)
    NullPosition.new
  end

  def to_s
    "no position"
  end

  def inside?(*)
    false
  end
end

class Client
  def initialize
    @tabletop = Arena.new 5, 5
    @robot = Robot.new arena: @tabletop
  end

  def parse(command)
    case command.strip
    when /place\s+(\d,\s*){2}[nesw]/
      @robot.place Position.new(place_params(command))
    when "move"
      @robot.move
    when "left"
      @robot.turn(:left)
    when "right"
      @robot.turn(:right)
    when "report"
      @robot.report
    else
      puts "invalid command"
    end
  end

  def main
    loop do
      print "Input command: "
      parse gets
      print "\n"
    end
  end

  private

  def place_params(command)
    params = command[/\s.*/].delete(" ").split(",")
    { x:         params[0].to_i,
      y:         params[1].to_i,
      direction: params[2].to_sym }
  end
end

Client.new.main
