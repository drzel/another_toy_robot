require "spec_helper"

describe ToyRobot do
  it "has a version number" do
    expect(ToyRobot::VERSION).not_to be nil
  end
end

describe Robot do
  context "when not placed" do
    let(:robot) { build(:robot) }

    describe "#left" do
      it "returns NullPosition" do
        robot.left
        expect(robot.instance_variable_get("@position").class).to eq NullPosition
      end
    end

    describe "#right" do
      it "returns NullPosition" do
        robot.right
        expect(robot.instance_variable_get("@position").class).to eq NullPosition
      end
    end

    describe "#move" do
      it "returns NullPosition" do
        robot.move
        expect(robot.instance_variable_get("@position").class).to eq NullPosition
      end
    end

    describe "#report" do
      it 'outputs "No position" to stdout' do
        expect { robot.report }.to output("No position\n").to_stdout
      end
    end
  end

  context "when placed" do
    let(:robot) { build(:robot_with_position) }

    describe "#left" do
      it "turns left" do
        LEFT_HASH  = { n: :w, w: :s, s: :e, e: :n }
        position = robot.instance_variable_get("@position")
        direction = position.instance_variable_get("@direction")
        robot.left
        new_position = robot.instance_variable_get("@position")
        new_direction = new_position.instance_variable_get("@direction")
        expect(new_direction).to eq LEFT_HASH[direction]
      end
    end

    describe "#right" do
      it "turns right" do
        RIGHT_HASH = { n: :e, e: :s, s: :w, w: :n }
        position = robot.instance_variable_get("@position")
        direction = position.instance_variable_get("@direction")
        robot.right
        new_position = robot.instance_variable_get("@position")
        new_direction = new_position.instance_variable_get("@direction")
        expect(new_direction).to eq RIGHT_HASH[direction]
      end
    end

    context "when next position is within arena" do
      describe "#move" do
        MOVE_HASH = { n: { x:  0, y:  1 },
                      e: { x:  1, y:  0 },
                      s: { x:  0, y: -1 },
                      w: { x: -1, y:  0 } }
        it "advances one position" do
          position = robot.instance_variable_get("@position")
          direction = position.instance_variable_get "@direction"
          x = position.instance_variable_get "@x"
          y = position.instance_variable_get "@y"
          robot.move
          new_position = robot.instance_variable_get "@position"
          new_x = new_position.instance_variable_get "@x"
          new_y = new_position.instance_variable_get "@y"
          expect
        end
      end
    end

    describe "#report" do
      it 'outputs "No position" to stdout' do
        expect { robot.report }.to output("No position\n").to_stdout
      end
    end
  end
end

describe NullPosition do
  let(:null_position) { build(:null_position) }

  describe "#advance" do
    it "returns self" do
      expect(null_position.advance).to eq null_position
    end
  end

  describe "#turn" do
    it "returns self" do
      expect(null_position.turn).to eq null_position
    end
  end

  describe "#to_s" do
    it 'returns "No position"' do
      expect(null_position.to_s).to eq "No position"
    end
  end

  describe "#inside?" do
    it "returns false" do
      expect(null_position.inside?).to eq false
    end
  end
end

# describe Client do
#   let(:client) { build(:client) }

#   describe "#sanitize" do
#     context "when valid" do
#       let(:command) { "move" }

#       it "returns 'move'" do
#         expect(client.sanitize(command)).to eq "move"
#       end
#     end

#     context "when odd casing" do
#       let(:command) { "LeFT" }

#       it "returns 'left'" do
#         expect(client.sanitize(command)).to eq "left"
#       end
#     end

#     context "when extra whitespace" do
#       let(:command) { " right  " }

#       it "returns 'right'" do
#         expect(client.sanitize(command)).to eq "right"
#       end
#     end

#     context "when odd casing and extra whitespace" do
#       let(:command) { " rePOrT " }

#       it "returns 'report'" do
#         expect(client.sanitize(command)).to eq "report"
#       end
#     end

#     context "when odd casing, extra whitespace with numbers and commas" do
#       let(:command) { " pLAce   1, 2, N  " }

#       it "returns 'place 1, 2, n'" do
#         expect(client.sanitize(command)).to eq "place 1, 2, n"
#       end
#     end
#   end
# end
