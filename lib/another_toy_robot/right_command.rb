require "another_toy_robot/command"

class RightCommand < Command
  def issue_command
    @target.right
  end
end
