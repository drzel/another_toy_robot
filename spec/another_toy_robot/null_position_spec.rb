# frozen_string_literal: true

describe NullPosition do
  let(:null_position) { build :null_position }

  describe '#advance' do
    it 'returns NullPosition' do
      expect(null_position.advance.class).to eq NullPosition
    end
  end

  describe '#left' do
    it 'returns NullPosition' do
      expect(null_position.left.class).to eq NullPosition
    end
  end

  describe '#right' do
    it 'returns NullPosition' do
      expect(null_position.right.class).to eq NullPosition
    end
  end

  describe '#to_s' do
    it 'returns "No position"' do
      expect(null_position.to_s).to eq 'No position'
    end
  end
end
