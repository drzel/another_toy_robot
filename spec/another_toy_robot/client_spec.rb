require "spec_helper"

describe Client do
  let(:client) { build :client }
  let(:robot) { client.instance_variable_get "@robot" }

  describe "#command_for" do
    let(:input) { build :input }

    it "sends to_class to input object" do
      dbl = double
      expect(input).to receive(:to_class) { dbl }
      allow(dbl).to receive(:new) { dbl }
      allow(dbl).to receive :execute
      client.command_for input
    end

    it "sends params to input object" do
      dbl = double
      allow(input).to receive(:to_class) { dbl }
      expect(input).to receive(:params)
      allow(dbl).to receive(:new) { dbl }
      allow(dbl).to receive :execute
      client.command_for input
    end

    it "sends new to returned command class with returned params" do
      klass = class_double "InvalidClass"
      instance = instance_double "InvalidClass"
      allow(input).to receive(:to_class) { klass }
      allow(input).to receive(:params)
      expect(klass).to(
        receive(:new).with(target: robot, params: input.params) { instance },
      )
      allow(instance).to receive :execute
      client.command_for input
    end

    it "sends execute to returned command instance" do
      klass = class_double "InvalidClass"
      instance = instance_double "InvalidClass"
      allow(input).to receive(:to_class) { klass }
      allow(input).to receive(:params)
      allow(klass).to receive(:new) { instance }
      expect(instance).to receive :execute
      client.command_for input
    end
  end
end
