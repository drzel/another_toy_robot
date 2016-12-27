require "another_toy_robot/null_coordinates"

class NullPosition
  attr_reader :coordinates, :direction

  def initialize
    @coordinates = NullCoordinates.new
    @direction   = nil
  end

  def to_s
    "No position"
  end

  def move
    self
  end

  def left
    self
  end

  def right
    self
  end
end
