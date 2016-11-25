class Command
  def initialize(robot: Robot.new, arena: NullArena.new, command:)
    @robot = robot
    @arena = arena
    @command = command.downcase.strip
  end

  def execute
    case @command
    when /place\s+(\d+,\s*){2}[nesw]/ then @robot.position = place_position
    when "move"                       then @robot.move
    when "left"                       then @robot.left
    when "right"                      then @robot.right
    when "report"                     then @robot.report
    else                              puts "Invalid command"
    end
  end

  private

  def params
    @params ||= @command[/\s.*/].delete(" ").split(",")
  end

  def place_params
    @place_params ||= { x:         params[0].to_i,
                        y:         params[1].to_i,
                        direction: params[2].to_sym }
  end

  def place_position
    position = NullPosition.new
    position.arena = @arena
    position.go_to(x:         place_params[:x],
                   y:         place_params[:y],
                   direction: place_params[:direction])
  end
end
