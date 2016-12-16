require "another_toy_robot/command"

class PlaceCommand < Command
  def post_initialize
    @params &&= @params.join.delete(" ").split ","
  end

  def issue_command
    @target.place Position.new(coordinates: coordinates,
                               direction:   direction)
  end

  private

  def valid?
    @params                 &&
      @params.length == 3   &&
      @params[0] =~ /^\d+$/ &&
      @params[1] =~ /^\d+$/ &&
      @params[2] =~ /^([nesw]|(north)|(east)|(south)|(west))$/
  end

  def coordinates
    x = @params[0].to_i
    y = @params[1].to_i
    Vector.new x: x, y: y
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
