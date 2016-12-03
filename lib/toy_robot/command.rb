class Command
  attr_reader :target, :params

  def initialize(target: nil, params: nil)
    @target = target
    @params = params

    post_initialize
  end

  def post_initialize; end

  def execute
    return InvalidCommand.new.execute unless valid?
    issue_command
  end

  def valid?
    true
  end
end

class PlaceCommand < Command
  def post_initialize
    @params = @params.join.delete(" ").split ","
  end

  private

  def issue_command
    @target.place Position.new(x_coord:   x_coord,
                               y_coord:   y_coord,
                               direction: direction)
  end

  def valid?
    @params.length == 3   &&
    @params[0] =~ /^\d+$/ &&
    @params[1] =~ /^\d+$/ &&
    @params[2] =~ /^([nesw]|(north)|(east)|(south)|(west))$/
  end

  def x_coord
    @params[0].to_i
  end

  def y_coord
    @params[1].to_i
  end

  def direction
    case @params[2]
    when "n", "north" then North
    when "e", "east"  then East
    when "s", "south" then South
    when "w", "west"  then West
    end
  end
end

class MoveCommand < Command
  def issue_command
    @target.move
  end
end

class LeftCommand < Command
  def issue_command
    @target.left
  end
end

class RightCommand < Command
  def issue_command
    @target.right
  end
end

class ReportCommand < Command
  def issue_command
    @target.report
  end
end

class InvalidCommand < Command
  def execute
    puts "Invalid command"
  end
end
