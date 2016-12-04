require "spec_helper"

describe Arena do
  let(:arena) { build :arena }

  describe "#inbounds?" do
    context "when coordinates are inbounds" do
      it "returns true" do
        expect(arena.inbounds?(0, 0)).to eq true
      end
    end

    context "when coordinates are out-of-bounds" do
      it "returns false" do
        expect(arena.inbounds?(10, 10)).to eq false
      end
    end
  end
end
