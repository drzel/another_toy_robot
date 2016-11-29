class Direction
  attr_reader :x_displacement, :y_displacement

  def to_s
    self.class.to_s.downcase
  end
end

class North < Direction
  def initialize
    @x_displacement = 0
    @y_displacement = 1
  end

  def left
    West.new
  end

  def right
    East.new
  end
end

class East < Direction
  def initialize
    @x_displacement = 1
    @y_displacement = 0
  end

  def left
    North.new
  end

  def right
    South.new
  end
end

class South < Direction
  def initialize
    @x_displacement = 0
    @y_displacement = -1
  end

  def left
    East.new
  end

  def right
    West.new
  end
end

class West < Direction
  def initialize
    @x_displacement = -1
    @y_displacement = 0
  end

  def left
    South.new
  end

  def right
    North.new
  end
end
