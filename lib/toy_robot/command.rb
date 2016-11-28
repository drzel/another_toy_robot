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
                              direction: direction_chooser(@params[2]))
    @robot.position = position
  end

  def direction_chooser(str)
    case str
    when "north" then North.new
    when "east" then East.new
    when "south" then South.new
    when "west" then West.new
    end
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
