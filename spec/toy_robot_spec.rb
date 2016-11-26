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
      expect(position).to receive(:turn).with :left
      robot.left
    end
  end

  describe "#right" do
    it "sends turn(:right) to @position" do
      position = robot.position
      expect(position).to receive(:turn).with :right
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
          expect(new_position.direction).to eq :w
        end
      end

      context "when turning right" do
        it "faces east" do
          new_position = position.turn :right
          expect(new_position.direction).to eq :e
        end
      end
    end

    context "when facing east" do
      let(:position) { build :real_position, direction: :e }

      context "when turning left" do
        it "faces north" do
          new_position = position.turn :left
          expect(new_position.direction).to eq :n
        end
      end

      context "when turning right" do
        it "faces south" do
          new_position = position.turn :right
          expect(new_position.direction).to eq :s
        end
      end
    end

    context "when facing south" do
      let(:position) { build :real_position, direction: :s }

      context "when turning left" do
        it "faces east" do
          new_position = position.turn :left
          expect(new_position.direction).to eq :e
        end
      end

      context "when turning right" do
        it "faces west" do
          new_position = position.turn :right
          expect(new_position.direction).to eq :w
        end
      end
    end

    context "when facing west" do
      let(:position) { build :real_position, direction: :w }

      context "when turning left" do
        it "faces south" do
          new_position = position.turn :left
          expect(new_position.direction).to eq :s
        end
      end

      context "when turning right" do
        it "faces north" do
          new_position = position.turn :right
          expect(new_position.direction).to eq :n
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

      it "sends execute to PlaceCommand.new" \
         "robot: @robot, arena: @table, command: input" do
        dbl = instance_double "PlaceCommand"
        expect(PlaceCommand).to(receive(:new).with(robot:   robot,
                                                   arena:   table,
                                                   command: input) { dbl })
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

    context 'when command is "report"' do
      input = "report"

      it "sends execute to ReportCommand.new robot: @robot" do
        dbl = instance_double "ReportCommand"
        expect(ReportCommand).to receive(:new).with(robot: robot) { dbl }
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

describe PlaceCommand do
  describe "#execute" do
    context "when given inbounds params" do
      let(:command) { build :place_command_with_inbounds_params }

      it "sets robot position to a RealPosition" do
        command.execute
        robot = command.instance_variable_get "@robot"
        expect(robot.position.class).to be RealPosition
      end

      it "sets robot position coordinates to input params" do
        command.execute
        robot = command.instance_variable_get "@robot"
        params = command.instance_variable_get "@params"
        expect(robot.position.x).to eq params[0].to_i
        expect(robot.position.y).to eq params[1].to_i
        expect(robot.position.direction).to eq params[2].to_sym
      end
    end

    context "when given out of bounds params" do
      let(:command) { build :place_command_with_out_of_bounds_params }

      it "sets robot position to a NullPosition" do
        command.execute
        robot = command.instance_variable_get "@robot"
        expect(robot.position.class).to be NullPosition
      end
    end
  end
end

describe MoveCommand do
  let(:command) { build :move_command }

  describe "#execute" do
    it "sends move to @robot" do
      robot = command.instance_variable_get "@robot"
      expect(robot).to receive :move
      command.execute
    end
  end
end

describe LeftCommand do
  let(:command) { build :left_command }

  describe "#execute" do
    it "sends left to @robot" do
      robot = command.instance_variable_get "@robot"
      expect(robot).to receive :left
      command.execute
    end
  end
end

describe RightCommand do
  let(:command) { build :right_command }

  describe "#execute" do
    it "sends right to @robot" do
      robot = command.instance_variable_get "@robot"
      expect(robot).to receive :right
      command.execute
    end
  end
end

describe ReportCommand do
  let(:command) { build :report_command }

  describe "#execute" do
    it "sends report to @robot" do
      robot = command.instance_variable_get "@robot"
      expect(robot).to receive :report
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

describe "integration tests" do
  let(:client) { build :client }

  describe "Example a) 'place 0, 0, n' 'move' 'report'" do
    commands = ["place 0, 0, n", "move", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it 'outputs "0, 1, n"' do
      expect { user_input }.to output("0, 1, n\n").to_stdout
    end
  end

  describe "Example b) 'place 0, 0, n' 'left' 'report'" do
    commands = ["place 0, 0, n", "left", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it 'outputs "0, 0, w"' do
      expect { user_input }.to output("0, 0, w\n").to_stdout
    end
  end

  describe "Example c) 'place 1, 2, e' 'move' 'move' 'left' 'move' 'report'" do
    commands = ["place 1, 2, e", "move", "move", "left", "move", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it 'outputs "3, 3, n"' do
      expect { user_input }.to output("3, 3, n\n").to_stdout
    end
  end

  describe "place, rotate, move and report with valid positions" do
    commands = ["place 0, 0, n", "right", "move", "move", "left", "move",
                "move", "right", "move", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it "reports position" do
      expect { user_input }.to output("3, 2, e\n").to_stdout
    end
  end

  describe "try to move out of bounds" do
    commands = ["place 4, 3, n", "move", "move", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it "ignores command, reports last inbounds position" do
      expect { user_input }.to output("4, 4, n\n").to_stdout
    end
  end

  describe "place robot in out of bounds position" do
    commands = ["place 10, 10, n", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it 'ignores command, reports "No position"' do
      expect { user_input }.to output("No position\n").to_stdout
    end
  end

  describe "move and rotate robot without placing in position" do
    commands = ["move", "left", "right", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it 'reports "No position"' do
      expect { user_input }.to output("No position\n").to_stdout
    end
  end

  describe "input an invalid command" do
    commands = ["derp"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it 'outputs "Invalid command"' do
      expect { user_input }.to output("Invalid command\n").to_stdout
    end
  end

  describe "validly place an already validly placed robot" do
    commands = ["place 0, 0, n", "place 2, 2, s", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it "reports the new position" do
      expect { user_input }.to output("2, 2, s\n").to_stdout
    end
  end

  describe "catch all" do
    commands = ["move", "left", "right", "derp", "report", "place 10, 10, n", \
                "move", "place 0, 0, s", "right", "move", "right", "move",    \
                "place 4, 4, s", "move", "move", "left", "move", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it "ignores command to walk off the edge" do
      expect { user_input }.to output(
        "Invalid command\nNo position\n4, 2, e\n",
      ).to_stdout
    end
  end
end
