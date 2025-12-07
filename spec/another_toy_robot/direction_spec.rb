
describe Direction do
  describe ".from_string(:north)" do
    subject { Direction.from_string(:north) }

    describe "#left" do
      it "returns west" do
        expect(subject.left.to_s).to eq "West"
      end
    end

    describe "#right" do
      it "returns east" do
        expect(subject.right.to_s).to eq "East"
      end
    end
  end

  describe ".from_string(:east)" do
    subject { Direction.from_string(:east) }

    describe "#left" do
      it "returns north" do
        expect(subject.left.to_s).to eq "North"
      end
    end

    describe "#right" do
      it "returns south" do
        expect(subject.right.to_s).to eq "South"
      end
    end
  end

  describe ".from_string(:south)" do
    subject { Direction.from_string(:south) }

    describe "#left" do
      it "returns east" do
        expect(subject.left.to_s).to eq "East"
      end
    end

    describe "#right" do
      it "returns west" do
        expect(subject.right.to_s).to eq "West"
      end
    end
  end

  describe ".from_string(:west)" do
    subject { Direction.from_string(:west) }

    describe "#left" do
      it "returns south" do
        expect(subject.left.to_s).to eq "South"
      end
    end

    describe "#right" do
      it "returns north" do
        expect(subject.right.to_s).to eq "North"
      end
    end
  end

  describe ".from_string with invalid direction" do
    it "raises InvalidDirection error" do
      expect { Direction.from_string(:invalid) }.to raise_error(Direction::InvalidDirection, "Invalid direction: invalid")
    end
  end
end
