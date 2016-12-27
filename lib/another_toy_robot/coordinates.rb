class Coordinates
  attr_accessor :x, :y

  def initialize(x: 0, y: 0)
    @x = x
    @y = y
  end

  def +(coords)
    Coordinates.new x: @x + coords.x, y: @y + coords.y
  end

  def ==(coords)
    @x == coords.x && @y == coords.y
  end

  def to_s
    "#{@x}, #{@y}"
  end
end
