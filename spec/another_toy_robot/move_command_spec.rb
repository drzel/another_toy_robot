require "spec_helper"

describe MoveCommand do
  let(:robot) { build :robot }
  let(:command) { build :move_command, target: robot }

  describe "#execute" do
    it "sends move to @target" do
      expect(command.target).to receive :move
      command.execute
    end
  end
end
