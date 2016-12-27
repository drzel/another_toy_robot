class Arena
  attr_accessor :columns, :rows

  def initialize(width: 5, height: 5)
    @columns = 0...width
    @rows    = 0...height
  end

  def cover?(coords)
    @columns.cover?(coords.x) && @rows.cover?(coords.y)
  end
end
