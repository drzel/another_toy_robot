# frozen_string_literal: true

class Direction
  class InvalidDirection < StandardError; end

  DIRECTIONS = {
    north: [0, 1],
    east: [1, 0],
    south: [0, -1],
    west: [-1, 0]
  }.freeze

  DIRECTION_NAMES = DIRECTIONS.invert.freeze

  attr_reader :x, :y

  # rubocop:disable Naming/MethodParameterName
  def initialize(x, y)
    @x = x
    @y = y
  end
  # rubocop:enable Naming/MethodParameterName

  def left
    Direction.new(-@y, @x)
  end

  def right
    Direction.new(@y, -@x)
  end

  def to_s
    DIRECTION_NAMES[[x, y]].to_s.capitalize
  end

  def self.from_string(str)
    x, y = DIRECTIONS[str.to_sym]
    raise(InvalidDirection, "Invalid direction: #{str}") unless x

    new(x, y)
  end
end
