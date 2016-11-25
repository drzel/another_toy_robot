class Client
  def initialize(robot: Robot.new, arena: NullArena.new, command:)
    @robot = robot
    @arena = arena
    @command = command.downcase.strip
  end

  def execute
    case @command
    when /place\s+(\d+,\s*){2}[nesw]/
      PlaceCommand.new(robot: @robot, arena: @arena, params: @params).execute
    when "move"
      MoveCommand.new(robot: @robot).execute
    when "left"
      LeftCommand.new(robot: @robot).execute
    when "right"
      RightCommand.new(robot: @robot).execute
    when "report"
      ReportCommand.new(robot: @robot).execute
    else
      InvalidCommand.new.execute
    end
  end

  private

  def params
    @params ||= @command[/\s.*/].delete(" ").split(",")
  end
end
