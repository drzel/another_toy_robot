require "spec_helper"

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
