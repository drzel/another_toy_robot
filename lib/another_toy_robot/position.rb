class Position
  attr_reader :coordinates, :direction

  def initialize(coordinates:, direction:)
    @coordinates = coordinates
    @direction   = direction
  end

  def move
    goto coordinates: @coordinates + @direction.displacement
  end

  def left
    goto direction: @direction.left
  end

  def right
    goto direction: @direction.right
  end

  def to_s
    "#{@coordinates}, #{@direction}"
  end

  private

  def goto(coordinates: @coordinates, direction: @direction)
    Position.new coordinates: coordinates, direction: direction
  end
end
