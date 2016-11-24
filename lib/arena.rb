class Arena
  def initialize(width, height)
    @max_x = width - 1
    @max_y = height - 1
  end

  def inbounds?(x, y)
    x.between?(0, @max_x) && y.between?(0, @max_y)
  end
end
