class Position
  attr_reader :coordinates, :direction

  def initialize(coordinates:, direction:)
    @coordinates = coordinates
    @direction   = direction
  end

  def move
    Position.new(coordinates: @coordinates + @direction.displacement,
                 direction:   @direction)
  end

  def left
    Position.new coordinates: @coordinates, direction: @direction.left
  end

  def right
    Position.new coordinates: @coordinates, direction: @direction.right
  end

  def to_s
    "#{@coordinates}, #{@direction}"
  end
end
