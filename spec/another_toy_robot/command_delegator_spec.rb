require "spec_helper"

describe CommandDelegator do
  let(:command_delegator) { build :command_delegator }

  describe "#execute" do
    context "when command is invalid" do
      it "sends execute to an instance of InvalidCommand" do
        expect(InvalidCommand).to receive(:new)
        command_delegator.execute
      end
    end
  end
end
