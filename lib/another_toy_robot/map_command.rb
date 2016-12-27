require "another_toy_robot/command"

class MapCommand < Command
  def issue_command
    puts Map.new(arena: @target.arena, object: @target).to_s
  end
end
