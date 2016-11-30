require "spec_helper"

describe Position do
  let(:position) { build :position }

  describe "#advance" do
    it "return a new instance of Position" do
      expect(position.advance.class).to be Position
    end

    it "changes new instance's x_coord by direction's X_DISPLACEMENT" do
      stub_const "#{position.direction}::X_DISPLACEMENT", 1
      x = position.x_coord
      new_x = position.advance.x_coord
      expect(new_x).to eq(x + 1)
    end

    it "changes new instance's y_coord by direction's Y_DISPLACEMENT" do
      stub_const "#{position.direction}::Y_DISPLACEMENT", 1
      y = position.y_coord
      new_y = position.advance.y_coord
      expect(new_y).to eq(y + 1)
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
      expect(position.to_s).to(
        match(/(\d+,\s){2}((North)|(East)|(South)|(West))$/),
      )
    end
  end
end
