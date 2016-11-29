class PlaceCommand
  def initialize(robot:, command:)
    @robot  = robot
    @params = command[/\s.*/].delete(" ").split(",")
  end

  def execute
    @robot.place Position.new(x_coord:   x_coord,
                              y_coord:   y_coord,
                              direction: direction)
  end

  private

  def x_coord
    @params[0].to_i
  end

  def y_coord
    @params[1].to_i
  end

  def direction
    case @params[2]
    when "n", "north" then North.new
    when "e", "east"  then East.new
    when "s", "south" then South.new
    when "w", "west"  then West.new
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
  def execute
    puts "Invalid command"
  end
end
