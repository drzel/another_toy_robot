require "spec_helper"

describe MoveCommand do
  let(:robot) { build :robot }
  let(:command) { build :move_command, robot: robot }

  describe "#execute" do
    it "sends move to @robot" do
      expect(command.robot).to receive :move
      command.execute
    end
  end
end
