class North
  attr_reader :x_displacement, :y_displacement, :to_s

  def initialize
    @x_displacement = 0
    @y_displacement = 1
    @to_s           = "north"
  end

  def left
    West.new
  end

  def right
    East.new
  end
end

class East
  attr_reader :x_displacement, :y_displacement, :to_s

  def initialize
    @x_displacement = 1
    @y_displacement = 0
    @to_s           = "east"
  end

  def left
    North.new
  end

  def right
    South.new
  end
end

class South
  attr_reader :x_displacement, :y_displacement, :to_s

  def initialize
    @x_displacement = 0
    @y_displacement = -1
    @to_s           = "south"
  end

  def left
    East.new
  end

  def right
    West.new
  end
end

class West
  attr_reader :x_displacement, :y_displacement, :to_s

  def initialize
    @x_displacement = -1
    @y_displacement = 0
    @to_s           = "west"
  end

  def left
    South.new
  end

  def right
    North.new
  end
end
