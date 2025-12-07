# frozen_string_literal: true

describe LeftCommand do
  let(:robot) { build :robot }
  let(:command) { build :left_command, target: robot }

  describe '#execute' do
    it 'sends left to @target' do
      expect(command.target).to receive :left
      command.execute
    end
  end
end
