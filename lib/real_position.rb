class RealPosition < AbstractPosition
  ROTATION     = { left: -1, right: 1 }.freeze
  DISPLACEMENT = { n: { x:  0, y:  1 },
                   e: { x:  1, y:  0 },
                   s: { x:  0, y: -1 },
                   w: { x: -1, y:  0 } }.freeze

  def initialize(x:, y:, direction:, arena: NullArena.new)
    @x         = x
    @y         = y
    @direction = direction
    @arena     = arena
  end

  def advance
    x = @x + DISPLACEMENT[@direction][:x]
    y = @y + DISPLACEMENT[@direction][:y]
    go_to x, y, @direction
  end

  def turn(hand_side)
    compass = DISPLACEMENT.keys
    index = (compass.find_index(@direction) + ROTATION[hand_side]) % 4
    go_to @x, @y, compass[index]
  end

  def to_s
    "#{@x}, #{@y}, #{@direction}"
  end
end
