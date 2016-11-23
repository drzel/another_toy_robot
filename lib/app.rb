class App
  def initialize(robot)
    @robot = robot
  end

  def main
    loop do
      print "Input command: "
      Command.new(@robot, gets).execute
      puts
    end
  end
end
