class Client
  def initialize
    @robot = Robot.new
    @table = Arena.new width: 5, height: 5
  end

  def instruction(cmd)
    case cmd.strip
    when /place\s+(\d+,\s*){2}[nesw]/
      PlaceCommand.new(robot: @robot, arena: @table, params: @params).execute
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
