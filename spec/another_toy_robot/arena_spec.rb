# frozen_string_literal: true

describe Arena do
  let(:arena) { build :arena }

  describe '#inbounds?' do
    context 'when position is inbounds' do
      let(:position) { build :position }

      it 'returns true' do
        expect(arena.inbounds?(position)).to eq true
      end
    end

    context 'when position is out-of-bounds' do
      let(:position) { build :out_of_bounds_position }

      it 'returns false' do
        expect(arena.inbounds?(position)).to eq false
      end
    end

    context 'when null_position' do
      let(:position) { build :null_position }

      it 'returns false' do
        expect(arena.inbounds?(position)).to eq false
      end
    end
  end
end
