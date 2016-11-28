require "spec_helper"

describe RealPosition do
  describe "#advance" do
    context "when facing north" do
      let(:position) { build :real_position_facing_north }

      it "increments y coordinate by 1" do
        y_coordinate = position.y_coord
        expect(position.advance.y_coord).to eq(y_coordinate + 1)
      end
    end

    context "when facing east" do
      let(:position) { build :real_position_facing_east }

      it "increments x coordinate by 1" do
        x_coordinate = position.x_coord
        expect(position.advance.x_coord).to eq(x_coordinate + 1)
      end
    end

    context "when facing south" do
      let(:position) { build :real_position_facing_south }

      it "decrements y coordinate by 1" do
        y_coordinate = position.y_coord
        expect(position.advance.y_coord).to eq(y_coordinate - 1)
      end
    end

    context "when facing west" do
      let(:position) { build :real_position_facing_west }

      it "decrements x coordinate by 1" do
        x_coordinate = position.x_coord
        expect(position.advance.x_coord).to eq(x_coordinate - 1)
      end
    end
  end

  describe "#turn" do
    context "when facing north" do
      let(:position) { build :real_position_facing_north }

      context "when turning left" do
        it "faces west" do
          expect(position.turn(:left).direction.class).to eq West
        end
      end

      context "when turning right" do
        it "faces east" do
          expect(position.turn(:right).direction.class).to eq East
        end
      end
    end

    context "when facing east" do
      let(:position) { build :real_position_facing_east }

      context "when turning left" do
        it "faces north" do
          expect(position.turn(:left).direction.class).to eq North
        end
      end

      context "when turning right" do
        it "faces south" do
          expect(position.turn(:right).direction.class).to eq South
        end
      end
    end

    context "when facing south" do
      let(:position) { build :real_position_facing_south }

      context "when turning left" do
        it "faces east" do
          expect(position.turn(:left).direction.class).to eq East
        end
      end

      context "when turning right" do
        it "faces west" do
          expect(position.turn(:right).direction.class).to eq West
        end
      end
    end

    context "when facing west" do
      let(:position) { build :real_position_facing_west }

      context "when turning left" do
        it "faces south" do
          expect(position.turn(:left).direction.class).to eq South
        end
      end

      context "when turning right" do
        it "faces north" do
          expect(position.turn(:right).direction.class).to eq North
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
