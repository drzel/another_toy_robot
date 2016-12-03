class Client
  attr_reader :robot

  def initialize
    @table = Arena.new width: 5, height: 5
    @robot = Robot.new arena: @table
  end

  def command_for(input)
    input.to_command(target: @robot).execute
  end
end
