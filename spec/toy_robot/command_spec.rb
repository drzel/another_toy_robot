require "spec_helper"

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
        expect(robot.position.x_coord).to eq params[0].to_i
        expect(robot.position.y_coord).to eq params[1].to_i
        expect(robot.position.direction.class).to eq North
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
