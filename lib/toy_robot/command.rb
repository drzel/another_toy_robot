class Command
  def initialize(robot: robot, **args)
    @robot = robot
    post_initialize args
  end

  def post_initialize(*); end

  def execute
    raise NotImplementedError
  end
end

class PlaceCommand < Command
  def post_initialize(command:, arena: NullArena.new)
    @command = command
    @arena = arena
  end

  def execute
    position = NullPosition.new arena: @arena
    position = position.go_to(x:         params[:x],
                              y:         params[:y],
                              direction: params[:direction])
    @robot.place position
  end

  private

  def params
    ary = @command[/\s.*/].delete(" ").split(",")
    { x:         ary[0].to_i,
      y:         ary[1].to_i,
      direction: ary[2].to_sym }
  end
end

class MoveCommand < Command
  def execute
    @robot.move
  end
end

class LeftCommand < Command
  def execute
    @robot.left
  end
end

class RightCommand < Command
  def execute
    @robot.right
  end
end

class ReportCommand < Command
  def execute
    @robot.report
  end
end

class InvalidCommand < Command
  def execute
    puts "Invalid command"
  end
end
