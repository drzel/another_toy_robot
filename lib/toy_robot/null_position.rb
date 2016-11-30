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

  def return_self
    self
  end

  alias advance return_self
  alias left    return_self
  alias right   return_self
end
