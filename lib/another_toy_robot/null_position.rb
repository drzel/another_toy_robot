class NullPosition
  attr_reader :coordinates, :direction

  def initialize
    @coordinates = NullVector.new
    @direction   = nil
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

  def at_coords?(*)
    false
  end
end

class NullVector
  attr_reader :x, :y

  def initialize
    @x = nil
    @y = nil
  end
end
