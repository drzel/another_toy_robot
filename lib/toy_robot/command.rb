class Command
  def initialize(robot: robot, params:, **args)
    @robot = robot
    @params = params
    post_initialize args
  end

  def post_initialize(*); end

  def execute
    raise NotImplementedError
  end
end

class PlaceCommand < Command
  def post_initialize(robot:, arena: NullArena.new)
    @robot = robot
    @arena = arena
  end

  def execute
    @robot.place position
  end

  private

  def position
    position = NullPosition.new
    position.arena = @arena
    position.go_to(x:         @params[0].to_i,
                   y:         @params[1].to_i,
                   direction: @params[2].to_sym)
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
