class Arena
  attr_accessor :width, :height

  def initialize(width:, height:)
    @width  = width
    @height = height
  end

  def inbounds?(x, y)
    x.between?(0, max_x) && y.between?(0, max_y)
  end

  private

  def max_x
    width - 1
  end

  def max_y
    height - 1
  end
end
