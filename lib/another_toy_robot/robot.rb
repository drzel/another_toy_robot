require "another_toy_robot/position"
require "another_toy_robot/null_position"
require "another_toy_robot/arena"

class Robot
  attr_reader :position, :arena

  def initialize(position: NullPosition.new, arena: Arena.new)
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
    return unless position.x_coord && position.y_coord
    return unless @arena.inbounds? position.x_coord, position.y_coord
    @position = position
  end
end
