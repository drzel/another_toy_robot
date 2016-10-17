require "spec_helper"

describe ToyRobot do
  it "has a version number" do
    expect(ToyRobot::VERSION).not_to be nil
  end

  describe "#sanitize" do
    it "returns a sanitized user command" do
      expect(ToyRobot.sanitize("  mOVe ")).to eq "move"
    end
  end
end
