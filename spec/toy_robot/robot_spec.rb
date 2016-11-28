require "spec_helper"

describe Robot do
  let(:robot) { build :robot }

  describe "#left" do
    it "sends turn(:left) to @position" do
      expect(robot.position).to receive(:turn).with :left
      robot.left
    end
  end

  describe "#right" do
    it "sends turn(:right) to @position" do
      expect(robot.position).to receive(:turn).with :right
      robot.right
    end
  end

  describe "#move" do
    context "when in a RealPosition" do
      let(:robot) { build :robot_in_real_position_facing_north }

      it "sends advance to @position" do
        dbl = double
        expect(robot.position).to receive(:advance) { dbl }
        allow(dbl).to receive_messages(x_coord: rand(0...5),
                                       y_coord: rand(0...5))
        robot.move
      end

      it "changes the robot's @position" do
        expect { robot.move }.to change { robot.position }
      end
    end

    context "when in NullPosition" do
      let(:robot) { build :robot }

      it "doesn't change the robot's @position" do
        expect { robot.move }.not_to change { robot.position }
      end
    end
  end

  describe "#place" do
    context "when in a RealPosition" do
      let(:robot) { build :robot_in_real_position_facing_north }

      it "changes the robot's position" do
        expect { robot.move }.to change { robot.position }
      end
    end
  end

  describe "#report" do
    it 'outputs "No position" to stdout' do
      expect { robot.report }.to output("No position\n").to_stdout
    end
  end
end
