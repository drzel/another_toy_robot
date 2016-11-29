require "spec_helper"

describe Position do
  let(:position) { build :position }

  describe "#advance" do
    it "sends x_displacement and y_displacment to @direction" do
      expect(position.direction).to receive(:x_displacement) { rand 0...5 }
      expect(position.direction).to receive(:y_displacement) { rand 0...5 }
      position.advance
    end

    it "return a new instance of Position" do
      expect(position.advance.class).to be Position
    end
  end

  describe "#left" do
    it "sends left to @direction" do
      expect(position.direction).to receive(:left)
      position.left
    end

    it "return a new instance of Position" do
      expect(position.advance.class).to be Position
    end
  end

  describe "#right" do
    it "sends right to @direction" do
      expect(position.direction).to receive(:right)
      position.right
    end

    it "return a new instance of Position" do
      expect(position.advance.class).to be Position
    end
  end

  describe "#to_s" do
    it "returns string of format 'x, y, d'" do
      expect(position.to_s).to match(/(\d+,\s){2}[nesw]/)
    end
  end
end
