require "spec_helper"

describe InvalidCommand do
  let(:command) { build :invalid_command }

  describe "#execute" do
    it 'outputs "Invalid command" to stdout' do
      expect { command.execute }.to output("Invalid command\n").to_stdout
    end
  end
end
