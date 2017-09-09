require "spec_helper"

describe ReportCommand do
  let(:robot) { build :robot }
  let(:command) { build :report_command, robot: robot }

  describe "#execute" do
    it "sends report to @robot" do
      expect(command.robot).to receive :report
      command.execute
    end
  end
end
