class Position
  attr_accessor :arena

  def initialize(arena: NullArena.new, **args)
    @arena = arena
    post_initialize args
  end

  def go_to(x: @x_coord, y: @y_coord, direction: @direction)
    if @arena.inbounds? x, y
      RealPosition.new x: x, y: y, direction: direction, arena: @arena
    else
      self
    end
  end
end

class RealPosition < Position
  attr_accessor :x_coord, :y_coord, :direction

  def post_initialize(x: 0, y: 0, direction: North.new)
    @x_coord   = x
    @y_coord   = y
    @direction = direction
  end

  def advance
    new_x = @x_coord + @direction.x_displacement
    new_y = @y_coord + @direction.y_displacement
    go_to x: new_x, y: new_y
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
