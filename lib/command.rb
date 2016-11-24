class Command
  def initialize(robot, arena, command)
    @robot = robot
    @arena = arena
    @command = command.downcase.strip
  end

  def execute
    case @command
    when /place\s+(\d+,\s*){2}[nesw]/ then @robot.place position
    when "move"                       then @robot.move
    when "left"                       then @robot.left
    when "right"                      then @robot.right
    when "report"                     then @robot.report
    else                              puts "Invalid command"
    end
  end

  private

  def param_ary
    @param_ary ||= @command[/\s.*/].delete(" ").split(",")
  end

  def place_params
    @params ||= { x:         param_ary[0].to_i,
                  y:         param_ary[1].to_i,
                  direction: param_ary[2].to_sym }
  end

  def position
    NullPosition.new(arena: @arena).go_to(x:         place_params[:x],
                                          y:         place_params[:y],
                                          direction: place_params[:direction])
  end
end
