require "another_toy_robot/direction"

class Position
  attr_reader :coordinates, :direction

  def initialize(coordinates: Vector.new, direction: North)
    @coordinates = coordinates
    @direction   = direction
  end

  def advance
    new_position coordinates: @coordinates + @direction.displacement
  end

  def left
    new_position direction: @direction.left
  end

  def right
    new_position direction: @direction.right
  end

  def to_s
    "#{@coordinates}, #{@direction}"
  end

  def at_coords?(x_coord, y_coord)
    @coordinates == Vector.new(x: x_coord, y: y_coord)
  end

  private

  def new_position(coordinates: @coordinates, direction: @direction)
    self.class.new coordinates: coordinates, direction: direction
  end
end

class Vector
  attr_reader :x, :y

  def initialize(x: 0, y: 0)
    @x = x
    @y = y
  end

  def ==(coords)
    @x == coords.x && @y == coords.y
  end

  def +(coords)
    self.class.new x: @x + coords.x, y: @y + coords.y
  end

  def *(scalar)
    self.class.new x: @x * scalar, y: @y * scalar
  end

  def to_s
    "#{@x}, #{@y}"
  end
end
