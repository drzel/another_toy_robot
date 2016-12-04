require "toy_robot/command"

class ReportCommand < Command
  def issue_command
    @target.report
  end
end
