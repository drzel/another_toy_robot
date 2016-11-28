class Position
  attr_accessor :arena

  def initialize(arena: NullArena.new, **args)
    @arena = arena
    post_initialize args
  end

  def go_to(x_coord: @x_coord, y_coord: @y_coord, direction: @direction)
    if @arena.inbounds? x_coord, y_coord
      RealPosition.new(x_coord:   x_coord,
                       y_coord:   y_coord,
                       direction: direction,
                       arena: @arena)
    else
      self
    end
  end
end

class RealPosition < Position
  attr_accessor :x_coord, :y_coord, :direction

  def post_initialize(x_coord: 0, y_coord: 0, direction: North.new)
    @x_coord   = x_coord
    @y_coord   = y_coord
    @direction = direction
  end

  def advance
    new_x = @x_coord + @direction.x_displacement
    new_y = @y_coord + @direction.y_displacement
    go_to x_coord: new_x, y_coord: new_y
  end

  def turn(hand_side)
    go_to direction: @direction.send(hand_side)
  end

  def to_s
    "#{@x_coord}, #{@y_coord}, #{@direction}"
  end
end

class NullPosition < Position
  def post_initialize(*); end

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
