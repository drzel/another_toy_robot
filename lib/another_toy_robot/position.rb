require "another_toy_robot/direction"

class Position
  attr_reader :x_coord, :y_coord, :direction

  def initialize(x_coord: 0, y_coord: 0, direction: Direction.from_string(:north))
    @x_coord   = x_coord
    @y_coord   = y_coord
    @direction = direction
  end

  def advance
    new_position(x_coord: @x_coord + @direction.x,
                 y_coord: @y_coord + @direction.y)
  end

  def left
    new_position direction: @direction.left
  end

  def right
    new_position direction: @direction.right
  end

  def to_s
    "#{@x_coord}, #{@y_coord}, #{@direction}"
  end

  private

  def new_position(x_coord: @x_coord, y_coord: @y_coord, direction: @direction)
    Position.new x_coord: x_coord, y_coord: y_coord, direction: direction
  end
end
