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

describe MoveCommand do
  let(:command) { build :move_command }

  describe "#execute" do
    it "sends move to @target" do
      expect(command.target).to receive :move
      command.execute
    end
  end
end

describe LeftCommand do
  let(:command) { build :left_command }

  describe "#execute" do
    it "sends left to @target" do
      expect(command.target).to receive :left
      command.execute
    end
  end
end

describe RightCommand do
  let(:command) { build :right_command }

  describe "#execute" do
    it "sends right to @target" do
      expect(command.target).to receive :right
      command.execute
    end
  end
end

describe ReportCommand do
  let(:command) { build :report_command }

  describe "#execute" do
    it "sends report to @target" do
      expect(command.target).to receive :report
      command.execute
    end
  end
end

describe InvalidCommand do
  let(:command) { build :invalid_command }

  describe "#execute" do
    it 'outputs "Invalid command" to stdout' do
      expect { command.execute }.to output("Invalid command\n").to_stdout
    end
  end
end
