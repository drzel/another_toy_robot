class PlaceCommand
  def initialize(robot:, arena: NullArena.new, command:)
    @robot  = robot
    @arena  = arena
    @params = command[/\s.*/].delete(" ").split(",")
  end

  def execute
    position = NullPosition.new arena: @arena
    position = position.go_to(x:         @params[0].to_i,
                              y:         @params[1].to_i,
                              direction: @params[2].to_sym)
    @robot.position = position
  end
end

class MoveCommand
  def initialize(robot:)
    @robot = robot
  end

  def execute
    @robot.move
  end
end

class LeftCommand
  def initialize(robot:)
    @robot = robot
  end

  def execute
    @robot.left
  end
end

class RightCommand
  def initialize(robot:)
    @robot = robot
  end

  def execute
    @robot.right
  end
end

class ReportCommand
  def initialize(robot:)
    @robot = robot
  end

  def execute
    @robot.report
  end
end

class InvalidCommand
  def intialize; end

  def execute
    puts "Invalid command"
  end
end
