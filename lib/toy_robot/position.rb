class Position
  attr_accessor :arena

  def initialize(arena: NullArena.new, **args)
    @arena = arena
    post_initialize args
  end

  def go_to(x: @x, y: @y, direction: @direction)
    if @arena.inbounds? x, y
      RealPosition.new x: x, y: y, direction: direction, arena: @arena
    else
      self
    end
  end
end

class RealPosition < Position
  attr_accessor :x, :y, :direction

  ROTATION     = { left: -1, right: 1 }.freeze
  DISPLACEMENT = { n: { x:  0, y:  1 },
                   e: { x:  1, y:  0 },
                   s: { x:  0, y: -1 },
                   w: { x: -1, y:  0 } }.freeze

  def post_initialize(x: 0, y: 0, direction: :n)
    @x         = x
    @y         = y
    @direction = direction
  end

  def advance
    new_x = @x + DISPLACEMENT[@direction][:x]
    new_y = @y + DISPLACEMENT[@direction][:y]
    go_to x: new_x, y: new_y
  end

  def turn(hand_side)
    compass = DISPLACEMENT.keys
    index = (compass.find_index(@direction) + ROTATION[hand_side]) % 4
    go_to direction: compass[index]
  end

  def to_s
    "#{@x}, #{@y}, #{@direction}"
  end
end

class NullPosition < Position
  def post_initialize(*)
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
