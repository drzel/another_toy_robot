require "spec_helper"

describe PlaceCommand do
  let(:robot) { build :robot }

  describe "#execute" do
    context "when params are valid" do
      let(:command) do
        build :place_command, target: robot, params: ["0", "0", "north"]
      end

      it "sends place to @target" do
        dbl = double
        allow(Position).to receive(:new) { dbl }
        expect(command.target).to receive(:place).with dbl
        command.execute
      end

      context 'when @params[2] is "north"' do
        let(:command) do
          build :place_command, target: robot, params: ["0", "0", "north"]
        end

        it "creates a new position facing north" do
          expect(Position).to receive(:new) do |args|
            expect(args[:direction].to_s).to eq "North"
          end
          allow(command.target).to receive :place
          command.execute
        end
      end

      context 'when @params[2] is "east"' do
        let(:command) do
          build :place_command, target: robot, params: ["0", "0", "east"]
        end

        it "creates a new position facing east" do
          expect(Position).to receive(:new) do |args|
            expect(args[:direction].to_s).to eq "East"
          end
          allow(command.target).to receive :place
          command.execute
        end
      end

      context 'when @params[2] is "south"' do
        let(:command) do
          build :place_command, target: robot, params: ["0", "0", "south"]
        end

        it "creates a new position facing south" do
          expect(Position).to receive(:new) do |args|
            expect(args[:direction].to_s).to eq "South"
          end
          allow(command.target).to receive :place
          command.execute
        end
      end

      context 'when @params[2] is "west"' do
        let(:command) do
          build :place_command, target: robot, params: ["0", "0", "west"]
        end

        it "creates a new position facing west" do
          expect(Position).to receive(:new) do |args|
            expect(args[:direction].to_s).to eq "West"
          end
          allow(command.target).to receive :place
          command.execute
        end
      end
    end

    context "when params are invalid" do
      let(:command) { build :place_command, params: ["derp"] }

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
