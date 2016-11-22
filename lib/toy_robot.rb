require "pry"

class Robot
  def initialize(arena:, position: NullPosition.new)
    @arena = arena
    @position = position
  end

  def place(position)
    if @arena.valid_position? position.x, position.y
      @position = position
    end
  end

  def report
    puts @position.to_s
  end

  def turn(direction)
    @position = @position.turn(direction)
  end

  def move
    place @position.move
  end
end

class Tabletop
  def initialize(width, height)
    @width = width
    @height = height
  end

  def valid_position?(x, y)
    x && y && x.between?(0, @width - 1) && y.between?(0, @height - 1)
  end
end

class Direction
  CARDINAL_POINTS = %i(n e s w).freeze
  ROTATION_INTS = { left: -1, right: 1 }.freeze

  def initialize(cardinal_point)
    @cardinal_point = cardinal_point
  end

  def turn(direction)
    Direction.new CARDINAL_POINTS[(to_i + ROTATION_INTS[direction]) % 4]
  end

  def to_sym
    @cardinal_point
  end

  def to_s
    @cardinal_point.to_s
  end

  private

  def to_i
    CARDINAL_POINTS.find_index(@cardinal_point)
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

  def initialize(x, y, cardinal_point)
    @x = x
    @y = y
    @direction = Direction.new cardinal_point
  end

  def move
    displacement = DISPLACEMENT[@direction.to_sym]
    new_x = @x + displacement[:x]
    new_y = @y + displacement[:y]
    Position.new new_x, new_y, @direction.to_sym
  end

  def turn(direction)
    Position.new @x, @y, @direction.turn(direction).to_sym
  end

  def to_s
    "#{@x}, #{@y}, #{@direction}"
  end
end

class NullPosition
  attr_reader :x, :y

  def initialize
    @x = nil
    @y = nil
    @direction = nil
  end

  def move
    NullPosition.new
  end

  def turn(*)
    NullPosition.new
  end

  def to_s
    "no position"
  end
end

class Client
  def initialize
    @tabletop = Tabletop.new(5, 5)
    @robot = Robot.new arena: @tabletop
  end

  def parse(command)
    case command.strip
    when /place\s+(\d,\s*){2}[nesw]/
      params = place_params(command)
      position = Position.new(params[:x],
                              params[:y],
                              params[:cardinal_point])
      @robot.place position
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
      print "\nInput command: "
      input = gets
      break if input == "exit"
      parse input
    end
  end

  private

  def place_params(command)
    params = command[/\s.*/].delete(" ").split(",")
    { x:              params[0].to_i,
      y:              params[1].to_i,
      cardinal_point: params[2].to_sym }
  end
end

Client.new.main
