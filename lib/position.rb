class Position
  attr_accessor :arena

  def initialize(arena: NullArena.new, **args)
    @arena = arena
    post_initialize args
  end

  private

  def go_to(x: @x, y: @y, direction: @direction)
    if @arena.inbounds? x, y
      RealPosition.new x: x, y: y, direction: direction, arena: @arena
    else
      self
    end
  end
end
