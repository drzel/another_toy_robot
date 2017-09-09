class LeftCommand
  include Command

  def issue_command
    @robot.left
  end
end
