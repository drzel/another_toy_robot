class Arena
  def initialize(width: 5, height: 5)
    @columns = 0...width
    @rows    = 0...height
  end

  def inbounds?(x_coord, y_coord)
    @columns.cover?(x_coord) && @rows.cover?(y_coord)
  end
end
