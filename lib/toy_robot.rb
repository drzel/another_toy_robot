require "toy_robot/version"
require "pry"

class Client
  attr_reader :invoker

  def initialize
    @invoker = Invoker.new
  end

  def main
    loop do
      puts "Enter command:"
      parse sanitize(gets)
    end
  end

  def parse(command)
    case command
    when "move"
      # @invoker.execute(MoveCommand.new(@robot))
    when "left"
      # @invoker.execute(LeftCommand.new(@robot))
    when "right"
      # @invoker.execute(RightCommand.new(@robot))
    when /place\s*(\d\s*,\s*){2}[nesw]/
      # @invoker.execute(PlaceCommand.new(@robot))
    else
      # error
    end
  end

  def sanitize(str)
    str.chomp.downcase.squeeze.strip
  end
end

class Invoker
  def execute(cmd)
    cmd.execute
  end
end

class Command
  attr_reader :obj

  def initialize(obj)
    @obj = obj
  end

  def execute
    raise NotImplementedError
  end
end

class Tabletop
  def initialize(x, y)
    @width = x
    @height = y
  end
end
