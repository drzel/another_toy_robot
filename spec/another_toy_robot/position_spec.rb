
describe Position do
  let(:position) { build :position }

  describe "#advance" do
    it "return a new instance of Position" do
      expect(position.advance.class).to be Position
    end

    it "advances x_coord by direction's x component" do
      x = position.x_coord
      direction_x = position.direction.x
      new_x = position.advance.x_coord
      expect(new_x).to eq(x + direction_x)
    end

    it "advances y_coord by direction's y component" do
      y = position.y_coord
      direction_y = position.direction.y
      new_y = position.advance.y_coord
      expect(new_y).to eq(y + direction_y)
    end
  end

  describe "#left" do
    it "sends left to @direction" do
      expect(position.direction).to receive(:left)
      position.left
    end

    it "return a new instance of Position" do
      expect(position.left.class).to be Position
    end
  end

  describe "#right" do
    it "sends right to @direction" do
      expect(position.direction).to receive(:right)
      position.right
    end

    it "return a new instance of Position" do
      expect(position.right.class).to be Position
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
