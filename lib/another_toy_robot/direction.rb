require "another_toy_robot/coordinates"

class North
  def self.displacement
    Coordinates.new y: 1
  end

  def self.left
    West
  end

  def self.right
    East
  end

  def self.to_char
    "↑"
  end
end

class East
  def self.displacement
    Coordinates.new x: 1
  end

  def self.left
    North
  end

  def self.right
    South
  end

  def self.to_char
    "→"
  end
end

class South
  def self.displacement
    Coordinates.new y: -1
  end

  def self.left
    East
  end

  def self.right
    West
  end

  def self.to_char
    "↓"
  end
end

class West
  def self.displacement
    Coordinates.new x: -1
  end

  def self.left
    South
  end

  def self.right
    North
  end

  def self.to_char
    "←"
  end
end
