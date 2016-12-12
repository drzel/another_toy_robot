module North
  X_DISPLACEMENT = 0
  Y_DISPLACEMENT = 1

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

module East
  X_DISPLACEMENT = 1
  Y_DISPLACEMENT = 0

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

module South
  X_DISPLACEMENT = 0
  Y_DISPLACEMENT = -1

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

module West
  X_DISPLACEMENT = -1
  Y_DISPLACEMENT = 0

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
