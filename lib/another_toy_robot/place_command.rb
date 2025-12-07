require "another_toy_robot/command"

class PlaceCommand < Command
  def post_initialize
    @params &&= @params.join.delete(" ").split ","
  end

  def issue_command
    @target.place Position.new(x_coord:   x_coord,
                               y_coord:   y_coord,
                               direction: direction)
  end

  private

  def valid?
    @params                 &&
      @params.length == 3   &&
      @params[0] =~ /^\d+$/ &&
      @params[1] =~ /^\d+$/ &&
      @params[2] =~ /^(north|east|south|west)$/
  end

  def x_coord
    @params[0].to_i
  end

  def y_coord
    @params[1].to_i
  end

  def direction
    Direction.from_string(@params[2])
  end
end
