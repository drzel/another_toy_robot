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
    return unless @arena.cover? position.coordinates
    @position = position
  end

  def move
    new_position = @position.move
    @position = new_position if @arena.cover?(new_position.coordinates)
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

  def to_char
    @position.direction.to_char
  end

  def at_coords?(coordinates)
    @position.coordinates == coordinates
  end
end
