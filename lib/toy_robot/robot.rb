class Robot
  attr_accessor :position, :arena

  def initialize(position: NullPosition.new, arena:)
    @position = position
    @arena    = arena
  end

  def place(new_position)
    @position = safely_go_to new_position
  end

  def move
    @position = safely_go_to @position.advance
  end

  def left
    @position = @position.left
  end

  def right
    @position = @position.right
  end

  def report
    puts @position.to_s
  end

  private

  def safely_go_to(new_position)
    if @arena.inbounds? new_position.x_coord, new_position.y_coord
      new_position
    else
      @position
    end
  end
end
