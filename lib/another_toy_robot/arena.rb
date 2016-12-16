class Arena
  attr_accessor :columns, :rows

  def initialize(width: 5, height: 5)
    @columns = 0...width
    @rows    = 0...height
  end

  def inbounds?(vector)
    @columns.cover?(vector.x) && @rows.cover?(vector.y)
  end
end
