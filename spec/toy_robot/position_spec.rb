require "spec_helper"

describe RealPosition do
  describe "#advance" do
    context "when facing north" do
      let(:north) { build :north }
      let(:position) { build :real_position, direction: north }

      it "increments y coordinate by 1" do
        y_coordinate = position.y_coord
        expect(position.advance.y_coord).to eq(y_coordinate + 1)
      end
    end

    context "when facing east" do
      let(:east) { build :east }
      let(:position) { build :real_position, direction: east }

      it "increments x coordinate by 1" do
        x_coordinate = position.x_coord
        expect(position.advance.x_coord).to eq(x_coordinate + 1)
      end
    end

    context "when facing south" do
      let(:south) { build :south }
      let(:position) { build :real_position, direction: south }

      it "decrements y coordinate by 1" do
        y_coordinate = position.y_coord
        expect(position.advance.y_coord).to eq(y_coordinate - 1)
      end
    end

    context "when facing west" do
      let(:west) { build :west }
      let(:position) { build :real_position, direction: west }

      it "decrements x coordinate by 1" do
        x_coordinate = position.x_coord
        expect(position.advance.x_coord).to eq(x_coordinate - 1)
      end
    end
  end

  describe "#turn" do
    context "when facing north" do
      let(:north) { build :north }
      let(:position) { build :real_position, direction: north }

      context "when turning left" do
        it "faces west" do
          new_position = position.turn :left
          expect(new_position.direction.class).to eq West
        end
      end

      context "when turning right" do
        it "faces east" do
          new_position = position.turn :right
          expect(new_position.direction.class).to eq East
        end
      end
    end

    context "when facing east" do
      let(:east) { build :east }
      let(:position) { build :real_position, direction: east }

      context "when turning left" do
        it "faces north" do
          new_position = position.turn :left
          expect(new_position.direction.class).to eq North
        end
      end

      context "when turning right" do
        it "faces south" do
          new_position = position.turn :right
          expect(new_position.direction.class).to eq South
        end
      end
    end

    context "when facing south" do
      let(:south) { build :south }
      let(:position) { build :real_position, direction: south }

      context "when turning left" do
        it "faces east" do
          new_position = position.turn :left
          expect(new_position.direction.class).to eq East
        end
      end

      context "when turning right" do
        it "faces west" do
          new_position = position.turn :right
          expect(new_position.direction.class).to eq West
        end
      end
    end

    context "when facing west" do
      let(:west) { build :west }
      let(:position) { build :real_position, direction: west }

      context "when turning left" do
        it "faces south" do
          new_position = position.turn :left
          expect(new_position.direction.class).to eq South
        end
      end

      context "when turning right" do
        it "faces north" do
          new_position = position.turn :right
          expect(new_position.direction.class).to eq North
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
        new_direction = [North.new, East.new, South.new, West.new].sample
        new_position = position.go_to(x_coord:  new_x,
                                      y_coord:  new_y,
                                      direction: new_direction)
        expect(new_position.x_coord).to eq new_x
        expect(new_position.y_coord).to eq new_y
        expect(new_position.direction).to eq new_direction
      end
    end

    context "with Arena" do
      let(:position) { build :real_position_with_arena }

      context "when new position is inbounds" do
        it "returns new position" do
          new_x = rand 0...5
          new_y = rand 0...5
          new_direction = [North.new, East.new, South.new, West.new].sample
          new_position = position.go_to(x_coord:   new_x,
                                        y_coord:   new_y,
                                        direction: new_direction)
          expect(new_position.x_coord).to eq new_x
          expect(new_position.y_coord).to eq new_y
          expect(new_position.direction).to eq new_direction
        end
      end

      context "when new position is out-of-bounds" do
        it "returns self" do
          new_x = 100
          new_position = position.go_to x_coord: new_x
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
