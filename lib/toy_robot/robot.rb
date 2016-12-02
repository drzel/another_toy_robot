class Robot
  attr_accessor :position, :arena

  def initialize(position: NullPosition.new, arena:)
    @position = position
    @arena    = arena
  end

  def place(position)
    safely_go_to position
  end

  def move
    safely_go_to @position.advance
  end

  def left
    safely_go_to @position.left
  end

  def right
    safely_go_to @position.right
  end

  def report
    puts @position.to_s
  end

  private

  def safely_go_to(position)
    @position = position if @arena.inbounds? position.x_coord, position.y_coord
  end
end
