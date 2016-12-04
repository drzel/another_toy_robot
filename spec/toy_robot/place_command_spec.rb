require "spec_helper"

describe PlaceCommand do
  let(:robot) { build :robot }

  describe "#execute" do
    context 'when @params[2] is "n"' do
      let(:command) do
        build :place_command, target: robot, params: ["0", "0", "n"]
      end

      it "creates a new position facing north" do
        expect(Position).to receive(:new).with hash_including(direction: North)
        allow(command.target).to receive :place
        command.execute
      end
    end

    context 'when @params[2] is "e"' do
      let(:command) do
        build :place_command, target: robot, params: ["0", "0", "e"]
      end

      it "creates a new position facing east" do
        expect(Position).to receive(:new).with hash_including(direction: East)
        allow(command.target).to receive :place
        command.execute
      end
    end

    context 'when @params[2] is "s"' do
      let(:command) do
        build :place_command, target: robot, params: ["0", "0", "s"]
      end

      it "creates a new position facing south" do
        expect(Position).to receive(:new).with hash_including(direction: South)
        allow(command.target).to receive :place
        command.execute
      end
    end

    context 'when @params[2] is "w"' do
      let(:command) do
        build :place_command, target: robot, params: ["0", "0", "w"]
      end

      it "creates a new position facing west" do
        expect(Position).to receive(:new).with hash_including(direction: West)
        allow(command.target).to receive :place
        command.execute
      end
    end

    context "when params are valid" do
      let(:command) do
        build :place_command, robot: robot, params: ["0", "0", "n"]
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
    let(:command) { build :place_command, params: ["derp"] }

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
