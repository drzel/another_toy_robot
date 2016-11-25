class Robot
  attr_accessor :position

  def initialize(position: NullPosition.new)
    @position = position
  end

  def move
    @position = @position.advance
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
end
