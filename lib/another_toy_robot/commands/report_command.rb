class ReportCommand
  include Command

  def issue_command
    @robot.report
  end
end
