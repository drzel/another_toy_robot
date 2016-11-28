class RealPosition
  attr_reader :x_coord, :y_coord, :direction

  def initialize(x_coord: 0, y_coord: 0, direction: North.new)
    @x_coord   = x_coord
    @y_coord   = y_coord
    @direction = direction
  end

  def advance
    x = @x_coord + @direction.x_displacement
    y = @y_coord + @direction.y_displacement
    RealPosition.new x_coord: x, y_coord: y, direction: @direction
  end

  def turn(hand_side)
    RealPosition.new(x_coord:   @x_coord,
                     y_coord:   @y_coord,
                     direction: @direction.send(hand_side))
  end

  def to_s
    "#{@x_coord}, #{@y_coord}, #{@direction}"
  end
end

class NullPosition
  attr_reader :x_coord, :y_coord, :direction

  def initialize
    @x_coord   = nil
    @y_coord   = nil
    @direction = nil
  end

  def advance
    self
  end

  def turn(*)
    self
  end

  def to_s
    "No position"
  end
end
