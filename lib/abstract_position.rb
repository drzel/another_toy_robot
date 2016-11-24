class AbstractPosition
  def go_to(x, y, direction)
    if @arena.inbounds? x, y
      RealPosition.new x: x, y: y, direction: direction, arena: @arena
    else
      self
    end
  end
end
