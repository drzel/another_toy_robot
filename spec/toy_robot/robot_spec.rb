require "spec_helper"

describe Robot do
  let(:robot) { build :robot }

  describe "#left" do
    it "sends left to @position" do
      expect(robot.position).to receive(:left)
      robot.left
    end
  end

  describe "#right" do
    it "sends right to @position" do
      expect(robot.position).to receive(:right)
      robot.right
    end
  end

  describe "#move" do
    let(:robot) { build :robot }

    it "sends advance to @position" do
      dbl = double
      expect(robot.position).to receive(:advance) { dbl }
      allow(dbl).to receive_messages(x_coord: rand(0...5),
                                     y_coord: rand(0...5))
      robot.move
    end

    context "when in null position" do
      it "doesn't change the robot's @position" do
        expect { robot.move }.not_to change { robot.position }
      end
    end

    context "when in position" do
      let(:robot) { build :robot_in_position }

      it "changes the robot's @position" do
        expect { robot.move }.to change { robot.position }
      end
    end
  end

  describe "#place" do
    let(:robot) { build :robot }
    let(:position) { build :position }

    it "changes the robot's position" do
      expect { robot.place position }.to change { robot.position }
    end
  end

  describe "#report" do
    it 'outputs "No position" to stdout' do
      expect { robot.report }.to output("No position\n").to_stdout
    end
  end
end
