require "spec_helper"

describe NullArena do
  let(:null_arena) { build :null_arena }

  describe "#inbounds?" do
    it "returns true" do
      expect(null_arena.inbounds?).to be true
    end
  end
end
