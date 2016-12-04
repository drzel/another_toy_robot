class MoveCommand < Command
  def issue_command
    @target.move
  end
end
