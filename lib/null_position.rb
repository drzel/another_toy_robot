class NullPosition < AbstractPosition
  def initialize(arena: NullArena.new)
    @arena = arena
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
