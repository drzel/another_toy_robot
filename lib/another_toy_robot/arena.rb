class Arena
  attr_accessor :columns, :rows

  def initialize(width: 5, height: 5)
    @columns = 0...width
    @rows    = 0...height
  end

  def inbounds?(position)
    @columns.cover?(position.x_coord) && @rows.cover?(position.y_coord)
  end
end
