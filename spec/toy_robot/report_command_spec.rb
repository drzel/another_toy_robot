require "spec_helper"

describe ReportCommand do
  let(:robot) { build :robot }
  let(:command) { build :report_command, target: robot }

  describe "#execute" do
    it "sends report to @target" do
      expect(command.target).to receive :report
      command.execute
    end
  end
end
