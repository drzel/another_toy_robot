require "spec_helper"

describe North do
  describe "#self.left" do
    it "returns West" do
      expect(North.left).to be West
    end
  end

  describe "#self.right" do
    it "returns East" do
      expect(North.right).to be East
    end
  end
end

describe East do
  describe "#self.left" do
    it "returns North" do
      expect(East.left).to be North
    end
  end

  describe "#self.right" do
    it "returns South" do
      expect(East.right).to be South
    end
  end
end

describe South do
  describe "#self.left" do
    it "returns East" do
      expect(South.left).to be East
    end
  end

  describe "#self.right" do
    it "returns West" do
      expect(South.right).to be West
    end
  end
end

describe West do
  describe "#self.left" do
    it "returns South" do
      expect(West.left).to be South
    end
  end

  describe "#self.right" do
    it "returns North" do
      expect(West.right).to be North
    end
  end
end
