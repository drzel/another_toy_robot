class Arena
  def initialize(width:, height:)
    @max_x = width - 1
    @max_y = height - 1
  end

  def inbounds?(x_coord, y_coord)
    x_coord && x_coord.between?(0, @max_x) &&
    y_coord && y_coord.between?(0, @max_y)
  end
end
