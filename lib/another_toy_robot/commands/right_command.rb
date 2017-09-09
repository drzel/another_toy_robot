class RightCommand
  include Command

  def issue_command
    @robot.right
  end
end
