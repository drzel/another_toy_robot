class Robot
  def initialize(arena:, position: NullPosition.new)
    @arena = arena
    @position = position
  end

  def place(position)
    go_to position
  end

  def move
    go_to @position.advance
  end

  def left
    @position = @position.turn :left
  end

  def right
    @position = @position.turn :right
  end

  def report
    puts @position.to_s
  end

  private

  def go_to(position)
    @position = position if position.inside? @arena.max_x, @arena.max_y
  end
end
