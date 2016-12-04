class Arena
  def initialize(width:, height:)
    @columns = 0...width
    @rows    = 0...height
  end

  def inbounds?(x_coord, y_coord)
    x_coord && @columns.cover?(x_coord) &&
    y_coord && @rows.cover?(y_coord)
  end
end
