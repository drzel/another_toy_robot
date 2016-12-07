describe Input do
  describe "#to_class" do
    context "when input is move" do
      let(:input) { build :input_move }

      it "returns MoveCommand" do
        expect(input.to_class).to be MoveCommand
      end
    end

    context "when input is left" do
      let(:input) { build :input_left }

      it "returns LeftCommand" do
        expect(input.to_class).to be LeftCommand
      end
    end

    context "when input is right" do
      let(:input) { build :input_right }

      it "returns RightCommand" do
        expect(input.to_class).to be RightCommand
      end
    end

    context "when input is report" do
      let(:input) { build :input_report }

      it "returns ReportCommand" do
        expect(input.to_class).to be ReportCommand
      end
    end

    context "when input is place 0, 0, n" do
      let(:input) { build :input_place }

      it "returns PlaceCommand" do
        expect(input.to_class).to be PlaceCommand
      end
    end

    context "when input is unknown" do
      let(:input) { build :input_derp }

      it "returns InvalidCommand" do
        expect(input.to_class).to be InvalidCommand
      end
    end
  end
end
