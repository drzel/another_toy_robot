class Command
  def initialize(robot: Robot.new, arena: NullArena.new, command:)
    @robot = robot
    @arena = arena
    @command = command.downcase.strip
  end

  def execute
    case @command
    when /place\s+(\d+,\s*){2}[nesw]/ then @robot.position = position
    when "move"                       then @robot.move
    when "left"                       then @robot.left
    when "right"                      then @robot.right
    when "report"                     then @robot.report
    else                              puts "Invalid command"
    end
  end

  private

  def place_params
    ary = @command[/\s.*/].delete(" ").split(",")
    @params ||= { x:         ary[0].to_i,
                  y:         ary[1].to_i,
                  direction: ary[2].to_sym }
  end

  def position
    position = NullPosition.new
    position.arena = @arena
    position.go_to(x:         place_params[:x],
                   y:         place_params[:y],
                   direction: place_params[:direction])
  end
end
