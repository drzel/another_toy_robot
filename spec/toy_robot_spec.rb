require "spec_helper"

describe ToyRobot do
  it "has a version number" do
    expect(ToyRobot::VERSION).not_to be nil
  end
end

describe Robot do
  let(:robot) { build :robot }

  describe "#left" do
    it "sends turn(:left) to @position" do
      position = robot.position
      expect(position).to receive(:turn).with(:left)
      robot.left
    end
  end

  describe "#right" do
    it "sends turn(:right) to @position" do
      position = robot.position
      expect(position).to receive(:turn).with(:right)
      robot.right
    end
  end

  describe "#move" do
    it "sends move to @position" do
      position = robot.position
      expect(position).to receive :advance
      robot.move
    end
  end

  describe "#report" do
    it 'outputs "No position" to stdout' do
      expect { robot.report }.to output("No position\n").to_stdout
    end
  end
end

describe Arena do
  let(:arena) { build :arena }

  describe "#inbounds?" do

    context "when coordinates are inbounds" do
      it "returns true" do
        expect(arena.inbounds?(0, 0)).to eq true
      end
    end

    context "when coordinates are out-of-bounds" do
      it "returns false" do
        expect(arena.inbounds?(10, 10)).to eq false
      end
    end
  end
end

describe NullArena do
  let(:arena) { build :null_arena }

  describe "#inbounds?" do
    it "returns true" do
      expect(arena.inbounds?(rand(100), rand(100))).to eq true
    end
  end
end

describe RealPosition do
  describe "#advance" do

    context "when facing north" do
      let(:position) { build :real_position, direction: :n }

      it "increments y coordinate by 1" do
        y_coordinate = position.y
        expect(position.advance.y).to eq(y_coordinate + 1)
      end
    end

    context "when facing east" do
      let(:position) { build :real_position, direction: :e }

      it "increments x coordinate by 1" do
        x_coordinate = position.x
        expect(position.advance.x).to eq(x_coordinate + 1)
      end
    end

    context "when facing south" do
      let(:position) { build :real_position, direction: :s }

      it "decrements y coordinate by 1" do
        y_coordinate = position.y
        expect(position.advance.y).to eq(y_coordinate - 1)
      end
    end

    context "when facing west" do
      let(:position) { build :real_position, direction: :w }

      it "decrements x coordinate by 1" do
        x_coordinate = position.x
        expect(position.advance.x).to eq(x_coordinate - 1)
      end
    end
  end

  describe "#turn" do

    context "when facing north" do
      let(:position) { build :real_position, direction: :n }

      context "when turning left" do
        it "faces west" do
          new_position = position.turn :left
          expect(new_position.direction).to eq(:w)
        end
      end

      context "when turning right" do
        it "faces east" do
          new_position = position.turn :right
          expect(new_position.direction).to eq(:e)
        end
      end
    end

    context "when facing east" do
      let(:position) { build :real_position, direction: :e }

      context "when turning left" do
        it "faces north" do
          new_position = position.turn :left
          expect(new_position.direction).to eq(:n)
        end
      end

      context "when turning right" do
        it "faces south" do
          new_position = position.turn :right
          expect(new_position.direction).to eq(:s)
        end
      end
    end

    context "when facing south" do
      let(:position) { build :real_position, direction: :s }

      context "when turning left" do
        it "faces east" do
          new_position = position.turn :left
          expect(new_position.direction).to eq(:e)
        end
      end

      context "when turning right" do
        it "faces west" do
          new_position = position.turn :right
          expect(new_position.direction).to eq(:w)
        end
      end
    end

    context "when facing west" do
      let(:position) { build :real_position, direction: :w }

      context "when turning left" do
        it "faces south" do
          new_position = position.turn :left
          expect(new_position.direction).to eq(:s)
        end
      end

      context "when turning right" do
        it "faces north" do
          new_position = position.turn :right
          expect(new_position.direction).to eq(:n)
        end
      end
    end
  end

  describe "#to_s" do
    let(:position) { build :real_position }

    it "returns string of format 'x, y, d'" do
      expect(position.to_s).to match(/(\d+,\s){2}[nesw]/)
    end
  end

  describe "#go_to" do

    context "with NullArena" do
      let(:position) { build :real_position }

      it "returns new position" do
        new_x = rand 0...100
        new_y = rand 0...100
        new_direction = %i(n e s w).sample
        new_position = position.go_to(x: new_x,
                                      y: new_y,
                                      direction: new_direction)
        expect(new_position.x).to eq new_x
        expect(new_position.y).to eq new_y
        expect(new_position.direction).to eq new_direction
      end
    end

    context "with Arena" do
      let(:position) { build :real_position_with_arena }

      context "when new position is inbounds" do
        it "returns new position" do
          new_x = rand 0...5
          new_y = rand 0...5
          new_direction = %i(n e s w).sample
          new_position = position.go_to(x: new_x,
                                        y: new_y,
                                        direction: new_direction)
          expect(new_position.x).to eq new_x
          expect(new_position.y).to eq new_y
          expect(new_position.direction).to eq new_direction
        end
      end

      context "when new position is out-of-bounds" do
        it "returns self" do
          new_x = 100
          new_position = position.go_to x: new_x
          expect(new_position).to be position
        end
      end
    end
  end
end

describe NullPosition do
  let(:null_position) { build :null_position }

  describe "#advance" do
    it "returns NullPosition" do
      expect(null_position.advance.class).to eq NullPosition
    end
  end

  describe "#turn" do
    it "returns NullPosition" do
      argument = [:left, :right].sample
      expect(null_position.turn(argument).class).to eq NullPosition
    end
  end

  describe "#to_s" do
    it 'returns "No position"' do
      expect(null_position.to_s).to eq "No position"
    end
  end
end

describe Client do
  let(:client) { build :client }
  let(:robot) { client.instance_variable_get "@robot" }
  let(:table) { client.instance_variable_get "@table" }

  describe "#instruction" do

    context 'when command is "place"' do
      input = "place 0, 0, n"

      it "sends execute to PlaceCommand.new robot: @robot, arena: @table, command: input" do
        dbl = instance_double "PlaceCommand"
        expect(PlaceCommand).to(
          receive(:new).with(robot: robot, arena: table, command: input) { dbl }
        )
        expect(dbl).to receive :execute
        client.instruction input
      end
    end

    context 'when command is "move"' do
      input = "move"

      it "sends execute to MoveCommand.new robot: @robot" do
        dbl = instance_double "MoveCommand"
        expect(MoveCommand).to receive(:new).with(robot: robot) { dbl }
        expect(dbl).to receive :execute
        client.instruction input
      end
    end

    context 'when command is "left"' do
      input = "left"

      it "sends execute to LeftCommand.new robot: @robot" do
        dbl = instance_double "LeftCommand"
        expect(LeftCommand).to receive(:new).with(robot: robot) { dbl }
        expect(dbl).to receive :execute
        client.instruction input
      end
    end

    context 'when command is "right"' do
      input = "right"

      it "sends execute to RightCommand.new robot: @robot" do
        dbl = instance_double "RightCommand"
        expect(RightCommand).to receive(:new).with(robot: robot) { dbl }
        expect(dbl).to receive :execute
        client.instruction input
      end
    end

    context "when command is invalid" do
      input = "derp"

      it "sends execute to InvalidCommand.new" do
        dbl = instance_double "InvalidCommand"
        expect(InvalidCommand).to receive(:new) { dbl }
        expect(dbl).to receive :execute
        client.instruction input
      end
    end
  end
end
