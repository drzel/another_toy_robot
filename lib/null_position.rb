class NullPosition < Position
  def post_initialize(*)
  end

  def advance
    self
  end

  def turn(*)
    self
  end

  def to_s
    "No position"
  end
end
