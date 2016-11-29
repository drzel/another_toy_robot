class Position
  attr_reader :x_coord, :y_coord, :direction

  def initialize(x_coord: 0, y_coord: 0, direction: North.new)
    @x_coord   = x_coord
    @y_coord   = y_coord
    @direction = direction
  end

  def advance
    Position.new(x_coord:   @x_coord + @direction.x_displacement,
                 y_coord:   @y_coord + @direction.y_displacement,
                 direction: @direction)
  end

  def left
    Position.new(x_coord:   @x_coord,
                 y_coord:   @y_coord,
                 direction: @direction.left)
  end

  def right
    Position.new(x_coord:   @x_coord,
                 y_coord:   @y_coord,
                 direction: @direction.right)
  end

  def to_s
    "#{@x_coord}, #{@y_coord}, #{@direction}"
  end
end
