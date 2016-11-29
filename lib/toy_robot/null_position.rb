class NullPosition
  attr_reader :x_coord, :y_coord, :direction, :to_s

  def initialize
    @x_coord   = nil
    @y_coord   = nil
    @direction = nil
    @to_s      = "No position"
  end

  def advance
    self
  end

  def turn(*)
    self
  end
end
