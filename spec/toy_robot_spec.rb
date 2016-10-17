require "spec_helper"

describe ToyRobot do
  it "has a version number" do
    expect(ToyRobot::VERSION).not_to be nil
  end
end

describe Client do
  let(:client) { build(:client) }

  describe "#sanitize" do
    context "when valid" do
      let(:command) { "move" }

      it "returns 'move'" do
        expect(client.sanitize(command)).to eq "move"
      end
    end

    context "when odd casing" do
      let(:command) { "LeFT" }

      it "returns 'left'" do
        expect(client.sanitize(command)).to eq "left"
      end
    end

    context "when extra whitespace" do
      let(:command) { " right  " }

      it "returns 'right'" do
        expect(client.sanitize(command)).to eq "right"
      end
    end

    context "when odd casing and extra whitespace" do
      let(:command) { " rePOrT " }

      it "returns 'report'" do
        expect(client.sanitize(command)).to eq "report"
      end
    end

    context "when odd casing, extra whitespace with numbers and commas" do
      let(:command) { " pLAce   1, 2, N  " }

      it "returns 'place 1, 2, n'" do
        expect(client.sanitize(command)).to eq "place 1, 2, n"
      end
    end
  end
end
