require "spec_helper"

describe PlaceCommand do
  context "with valid params" do
    let(:command) { build :place_command_with_valid_params }

    describe "#execute" do
      it "creates a new position with coordinates and direction" do
        expect(Position).to receive(:new).with(x_coord:   0,
                                               y_coord:   0,
                                               direction: North)
        allow(command.target).to receive(:place)
        command.execute
      end

      it "sends place to @target" do
        dbl = double
        allow(Position).to receive(:new) { dbl }
        expect(command.target).to receive(:place).with dbl
        command.execute
      end
    end
  end

  context "with invalid params" do
    let(:command) { build :place_command_with_invalid_params }

    describe "#execute" do
      it "creates a new InvalidCommand" do
        dbl = double
        expect(InvalidCommand).to receive(:new) { dbl }
        allow(dbl).to receive :execute
        command.execute
      end

      it "sends execute to new InvalidCommand" do
        dbl = double
        allow(InvalidCommand).to receive(:new) { dbl }
        expect(dbl).to receive :execute
        command.execute
      end
    end
  end
end
