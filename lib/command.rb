class Command
  def initialize(robot, arena, command)
    @robot = robot
    @arena = arena
    @command = command.downcase.strip
  end

  def execute
    case @command
    when /place\s+(\d+,\s*){2}[nesw]/ then @robot.place place_position
    when "move"                       then @robot.move
    when "left"                       then @robot.left
    when "right"                      then @robot.right
    when "report"                     then @robot.report
    else                              puts "Invalid command"
    end
  end

  private

  def place_position
    params    = @command[/\s.*/].delete(" ").split(",")
    x         = params[0].to_i
    y         = params[1].to_i
    direction = params[2].to_sym
    position  = NullPosition.new arena: @arena
    position.go_to x: x, y: y, direction: direction
  end
end
