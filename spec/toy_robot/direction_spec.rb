require "spec_helper"

describe North do
  let(:north) { build :north }

  describe "#to_s" do
    it 'returns "north"' do
      expect(north.to_s).to eq "north"
    end
  end

  describe "#x_displacement" do
    it "returns 0" do
      expect(north.x_displacement).to eq 0
    end
  end

  describe "#y_displacement" do
    it "returns 1" do
      expect(north.y_displacement).to eq 1
    end
  end

  describe "#left" do
    it "returns West.new" do
      expect(north.left.class).to eq West
    end
  end

  describe "#right" do
    it "returns East.new" do
      expect(north.right.class).to eq East
    end
  end
end

describe East do
  let(:east) { build :east }

  describe "#to_s" do
    it 'returns "east"' do
      expect(east.to_s).to eq "east"
    end
  end

  describe "#x_displacement" do
    it "returns 1" do
      expect(east.x_displacement).to eq 1
    end
  end

  describe "#y_displacement" do
    it "returns 0" do
      expect(east.y_displacement).to eq 0
    end
  end

  describe "#left" do
    it "returns North.new" do
      expect(east.left.class).to eq North
    end
  end

  describe "#right" do
    it "returns South.new" do
      expect(east.right.class).to eq South
    end
  end
end

describe South do
  let(:south) { build :south }

  describe "#to_s" do
    it 'returns "south"' do
      expect(south.to_s).to eq "south"
    end
  end

  describe "#x_displacement" do
    it "returns 0" do
      expect(south.x_displacement).to eq 0
    end
  end

  describe "#y_displacement" do
    it "returns -1" do
      expect(south.y_displacement).to eq(-1)
    end
  end

  describe "#left" do
    it "returns East.new" do
      expect(south.left.class).to eq East
    end
  end

  describe "#right" do
    it "returns West.new" do
      expect(south.right.class).to eq West
    end
  end
end

describe West do
  let(:west) { build :west }

  describe "#to_s" do
    it 'returns "west"' do
      expect(west.to_s).to eq "west"
    end
  end

  describe "#x_displacement" do
    it "returns -1" do
      expect(west.x_displacement).to eq(-1)
    end
  end

  describe "#y_displacement" do
    it "returns 0" do
      expect(west.y_displacement).to eq 0
    end
  end

  describe "#left" do
    it "returns South.new" do
      expect(west.left.class).to eq South
    end
  end

  describe "#right" do
    it "returns North.new" do
      expect(west.right.class).to eq North
    end
  end
end
