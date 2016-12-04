require "spec_helper"

describe LeftCommand do
  let(:command) { build :left_command }

  describe "#execute" do
    it "sends left to @target" do
      expect(command.target).to receive :left
      command.execute
    end
  end
end
