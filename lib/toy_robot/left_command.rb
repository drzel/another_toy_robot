class LeftCommand < Command
  def issue_command
    @target.left
  end
end
