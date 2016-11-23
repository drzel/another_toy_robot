class NullPosition
  def advance
    self
  end

  def turn(*)
    self
  end

  def to_s
    "No position"
  end

  def inside?(*)
    false
  end
end
