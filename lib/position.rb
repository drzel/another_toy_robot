class Position
  COMPASS      = %i(n e s w).freeze
  ROTATION     = { left: -1, right: 1 }.freeze
  DISPLACEMENT = { n: { x: 0,  y: 1  },
                   e: { x: 1,  y: 0  },
                   s: { x: 0,  y: -1 },
                   w: { x: -1, y: 0  } }.freeze

  def initialize(x:, y:, direction:)
    @x         = x
    @y         = y
    @direction = direction
  end

  def advance
    displacement = DISPLACEMENT[@direction]
    new_x        = @x + displacement[:x]
    new_y        = @y + displacement[:y]
    Position.new x: new_x, y: new_y, direction: @direction
  end

  def turn(hand_side)
    index = (COMPASS.find_index(@direction) + ROTATION[hand_side]) % 4
    Position.new x: @x, y: @y, direction: COMPASS[index]
  end

  def inside?(x, y)
    @x.between?(0, x) && @y.between?(0, y)
  end

  def to_s
    "#{@x}, #{@y}, #{@direction}"
  end
end
