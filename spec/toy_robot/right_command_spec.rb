require "spec_helper"

describe RightCommand do
  let(:command) { build :right_command }

  describe "#execute" do
    it "sends right to @target" do
      expect(command.target).to receive :right
      command.execute
    end
  end
end
