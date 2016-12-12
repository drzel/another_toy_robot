require "another_toy_robot/position"
require "another_toy_robot/null_position"
require "another_toy_robot/arena"
require "another_toy_robot/null_arena"
require "another_toy_robot/map"

class Robot
  attr_accessor :arena
  attr_reader :position

  def initialize(position: NullPosition.new, arena: NullArena.new)
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

  def display_map
    puts Map.new(object: self, arena: @arena).to_s
  end

  def to_char
    @position.direction.to_char
  end

  def at_coords?(x_coord, y_coord)
    @position.x_coord == x_coord && @position.y_coord == y_coord
  end

  private

  def safely_go_to(position)
    return unless @arena.inbounds? position
    @position = position
  end
end
