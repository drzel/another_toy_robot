describe Input do
  let(:robot) { build :robot }

  describe "#new_command" do
    context "when input is move" do
      let(:input) { build :input_move }

      it "creates a new MoveCommand" do
        expect(MoveCommand).to receive(:new).with(target: robot,
                                                  params: [])
        input.new_command robot
      end
    end

    context "when input is left" do
      let(:input) { build :input_left }

      it "creates a new LeftCommand" do
        expect(LeftCommand).to receive(:new).with(target: robot,
                                                  params: [])
        input.new_command robot
      end
    end

    context "when input is right" do
      let(:input) { build :input_right }

      it "creates a new RightCommand" do
        expect(RightCommand).to receive(:new).with(target: robot,
                                                   params: [])
        input.new_command robot
      end
    end

    context "when input is report" do
      let(:input) { build :input_report }

      it "creates a new ReportCommand" do
        expect(ReportCommand).to receive(:new).with(target: robot,
                                                    params: [])
        input.new_command robot
      end
    end

    context "when input is place 0, 0, n" do
      let(:input) { build :input_place }

      it "creates a new PlaceCommand" do
        expect(PlaceCommand).to receive(:new).with(target: robot,
                                                   params: ["0,", "0,", "n"])
        input.new_command robot
      end
    end

    context "when input is unknown" do
      let(:input) { build :input_derp }

      it "creates a new InvalidCommand" do
        expect(InvalidCommand).to receive(:new).with(target: robot,
                                                     params: [])
        input.new_command robot
      end
    end
  end
end
