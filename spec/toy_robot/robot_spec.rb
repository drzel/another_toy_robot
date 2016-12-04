require "spec_helper"

describe Robot do
  context "when in null position" do
    let(:robot) { build :robot }

    describe "#place" do
      let(:position) { build :position }

      it "changes @position" do
        expect { robot.place position }.to change { robot.position }
      end
    end

    describe "#move" do
      it "sends advance to @position" do
        dbl = double
        expect(robot.position).to receive(:advance) { dbl }
        allow(dbl).to receive_messages(x_coord: rand(0...5),
                                       y_coord: rand(0...5))
        robot.move
      end

      it "doesn't change @position" do
        expect { robot.move }.not_to change { robot.position }
      end
    end

    describe "#left" do
      it "sends left to @position" do
        expect(robot.position).to receive(:left)
        allow(robot).to receive(:safely_go_to)
        robot.left
      end

      it "doesn't change @position" do
        expect { robot.left }.to_not change { robot.position }
      end
    end

    describe "#right" do
      it "sends right to @position" do
        expect(robot.position).to receive(:right)
        allow(robot).to receive(:safely_go_to)
        robot.right
      end

      it "doesn't change @position" do
        expect { robot.right }.to_not change { robot.position }
      end
    end

    describe "#report" do
      it 'outputs "No position" to stdout' do
        expect { robot.report }.to output("No position\n").to_stdout
      end
    end
  end

  context "when in position" do
    let(:position) { build :position }
    let(:robot) { build :robot, position: position }

    describe "#place" do
      let(:new_position) { build :position }

      it "changes @position" do
        expect { robot.place new_position }.to change { robot.position }
      end
    end

    describe "#move" do
      it "sends advance to @position" do
        dbl = double
        expect(robot.position).to receive(:advance) { dbl }
        allow(dbl).to receive_messages(x_coord: rand(0...5),
                                       y_coord: rand(0...5))
        robot.move
      end

      it "changes @position" do
        expect { robot.move }.to change { robot.position }
      end
    end

    describe "#left" do
      it "sends left to @position" do
        expect(robot.position).to receive(:left)
        allow(robot).to receive(:safely_go_to)
        robot.left
      end

      it "changes @position" do
        expect { robot.left }.to change { robot.position }
      end
    end

    describe "#right" do
      it "sends right to @position" do
        expect(robot.position).to receive(:right)
        allow(robot).to receive(:safely_go_to)
        robot.right
      end

      it "changes @position" do
        expect { robot.right }.to change { robot.position }
      end
    end

    describe "#report" do
      it 'outputs string of format "x, y, d" to stdout' do
        expect { robot.report }.to output(
          match(/(\d+,\s){2}((North)|(East)|(South)|(West))$/),
        ).to_stdout
      end
    end
  end
end
