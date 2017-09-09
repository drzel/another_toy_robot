require "spec_helper"

describe RightCommand do
  let(:robot) { build :robot }
  let(:command) { build :right_command, robot: robot }

  describe "#execute" do
    it "sends right to @robot" do
      expect(command.robot).to receive :right
      command.execute
    end
  end
end
