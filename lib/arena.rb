class Arena
  attr_reader :max_x, :max_y

  def initialize(width, height)
    @max_x = width - 1
    @max_y = height - 1
  end
end
