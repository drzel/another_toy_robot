# frozen_string_literal: true

describe RightCommand do
  let(:robot) { build :robot }
  let(:command) { build :right_command, target: robot }

  describe '#execute' do
    it 'sends right to @target' do
      expect(command.target).to receive :right
      command.execute
    end
  end
end
