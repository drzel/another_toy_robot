class MoveCommand
  include Command

  def issue_command
    @robot.move
  end
end
