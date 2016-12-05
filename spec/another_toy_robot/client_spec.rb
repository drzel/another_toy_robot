require "spec_helper"

describe Client do
  let(:client) { build :client }
  let(:robot) { client.instance_variable_get "@robot" }

  describe "#command_for" do
    let(:input) { build :input }

    it "sends new_command with @robot to input object" do
      dbl = double
      expect(input).to receive(:new_command).with(robot) { dbl }
      allow(dbl).to receive :execute
      client.command_for input
    end

    it "sends execute to returned command object" do
      dbl = double
      allow(input).to receive(:new_command).with(robot) { dbl }
      expect(dbl).to receive :execute
      client.command_for input
    end
  end
end
