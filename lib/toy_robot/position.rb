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

class North
  def left; West.new; end
  def right; East.new; end
  def x_displacement; 0; end
  def y_displacement; 1; end
  def to_s; "north"; end
end

class East
  def left; North.new; end
  def right; South.new; end
  def x_displacement; 1; end
  def y_displacement; 0; end
  def to_s; "east"; end
end

class South
  def left; East.new; end
  def right; West.new; end
  def x_displacement; 0; end
  def y_displacement; -1; end
  def to_s; "south"; end
end

class West
  def left; South.new; end
  def right; North.new; end
  def x_displacement; -1; end
  def y_displacement; 0; end
  def to_s; "west"; end
end
