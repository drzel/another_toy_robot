class NullPosition
  attr_reader :x_coord, :y_coord, :direction

  def initialize
    @x_coord   = nil
    @y_coord   = nil
    @direction = nil
  end

  def to_s
    "No position"
  end

  def advance
    self
  end

  def left
    self
  end

  def right
    self
  end
end
