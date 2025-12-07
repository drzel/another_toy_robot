class Direction
  DIRECTIONS = {
    north: [0, 1],
    east:  [1, 0],
    south: [0, -1],
    west:  [-1, 0]
  }.freeze

  DIRECTION_NAMES = DIRECTIONS.invert.freeze

  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def left
    Direction.new(-@y, @x)
  end

  def right
    Direction.new(@y, -@x)
  end

  def to_s
    DIRECTION_NAMES[[x, y]].to_s.capitalize
  end

  def self.from_string(str)
    x, y = DIRECTIONS[str.to_sym]
    new(x, y) if x
  end
end
