# frozen_string_literal: true

require "another_toy_robot/command"

class MoveCommand < Command
  def issue_command
    @target.move
  end
end
