require "another_toy_robot/position"
require "another_toy_robot/null_position"
require "another_toy_robot/arena"

class Robot
  attr_reader :position

  def initialize(arena:, position: NullPosition.new)
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
    return unless @arena.inbounds? position
    @position = position
  end
end
