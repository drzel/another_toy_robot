require "toy_robot/direction"

class Position
  attr_accessor :x_coord, :y_coord, :direction

  def initialize(x_coord: 0, y_coord: 0, direction: North)
    @x_coord   = x_coord
    @y_coord   = y_coord
    @direction = direction
  end

  def advance
    new_position(x_coord: @x_coord + @direction::X_DISPLACEMENT,
                 y_coord: @y_coord + @direction::Y_DISPLACEMENT)
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
