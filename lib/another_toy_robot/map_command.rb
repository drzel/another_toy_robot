require "another_toy_robot/command"

class MapCommand < Command
  def issue_command
    @target.display_map
  end
end
