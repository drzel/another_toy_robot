require "spec_helper"

describe ToyRobot do
  it "has a version number" do
    expect(ToyRobot::VERSION).not_to be nil
  end

  describe "#main" do
    it "creates a new instance of client" do
      expect(Client).to receive(:new)
      allow(ToyRobot).to receive(:loop)
      ToyRobot.main
    end

    it "sends parse with user input to client" do
      dbl = instance_double "Client"
      expect(Client).to receive(:new) { dbl }
      allow(ToyRobot).to receive :print
      expect(ToyRobot).to receive(:get_input).and_return "move", "exit"
      expect(dbl).to receive(:parse).with "move"
      ToyRobot.main
    end
  end

  describe "#get_input" do
    it "returns a sanitized user input" do
      expect(ToyRobot).to receive(:gets) { " MOVE " }
      expect(ToyRobot.get_input).to eq "move"
    end
  end
end

describe "Integration" do
  describe "Example a) 'place 0, 0, north' 'move' 'report'" do
    it 'outputs "0, 1, North"' do
      commands = ["place 0, 0, north", "move", "report", "exit"]

      allow(ToyRobot).to receive :print
      expect(ToyRobot).to receive(:gets).and_return(*commands)
      expect { ToyRobot.main }.to output("0, 1, North\n").to_stdout
    end
  end

  describe "Example b) 'place 0, 0, north' 'left' 'report'" do
    it 'outputs "0, 0, west"' do
      commands = ["place 0, 0, north", "left", "report", "exit"]

      allow(ToyRobot).to receive :print
      expect(ToyRobot).to receive(:gets).and_return(*commands)
      expect { ToyRobot.main }.to output("0, 0, West\n").to_stdout
    end
  end

  describe "Example c) 'place 1, 2, east' 'move' 'move' 'left' 'move' " \
           "'report'" do
    it 'outputs "3, 3, north"' do
      commands = ["place 1, 2, east", "move", "move", "left", "move", \
                  "report", "exit"]

      allow(ToyRobot).to receive :print
      expect(ToyRobot).to receive(:gets).and_return(*commands)
      expect { ToyRobot.main }.to output("3, 3, North\n").to_stdout
    end
  end

  describe "place, rotate, move and report with valid positions" do
    it "reports position" do
      commands = ["place 0, 0, north", "right", "move", "move", "left", "move",
                  "move", "right", "move", "report", "exit"]

      allow(ToyRobot).to receive :print
      expect(ToyRobot).to receive(:gets).and_return(*commands)
      expect { ToyRobot.main }.to output("3, 2, East\n").to_stdout
    end
  end

  describe "try to move out of bounds" do
    it "ignores command, reports last inbounds position" do
      commands = ["place 4, 3, north", "move", "move", "report", "exit"]

      allow(ToyRobot).to receive :print
      expect(ToyRobot).to receive(:gets).and_return(*commands)
      expect { ToyRobot.main }.to output("4, 4, North\n").to_stdout
    end
  end

  describe "place robot in out of bounds position" do
    it 'ignores command, reports "No position"' do
      commands = ["place 10, 10, north", "report", "exit"]

      allow(ToyRobot).to receive :print
      expect(ToyRobot).to receive(:gets).and_return(*commands)
      expect { ToyRobot.main }.to output("No position\n").to_stdout
    end
  end

  describe "move and rotate robot without placing in position" do
    it 'reports "No position"' do
      commands = ["move", "left", "right", "report", "exit"]

      allow(ToyRobot).to receive :print
      expect(ToyRobot).to receive(:gets).and_return(*commands)
      expect { ToyRobot.main }.to output("No position\n").to_stdout
    end
  end

  describe "input an invalid command" do
    it 'outputs "Invalid command"' do
      commands = ["derp", "exit"]

      allow(ToyRobot).to receive :print
      expect(ToyRobot).to receive(:gets).and_return(*commands)
      expect { ToyRobot.main }.to output("Invalid command\n").to_stdout
    end
  end

  describe "validly place an already validly placed robot" do
    it "reports the new position" do
      commands = ["place 0, 0, north", "place 2, 2, south", "report", "exit"]

      allow(ToyRobot).to receive :print
      expect(ToyRobot).to receive(:gets).and_return(*commands)
      expect { ToyRobot.main }.to output("2, 2, South\n").to_stdout
    end
  end

  describe "catch all" do
    it "does it all" do
      commands = ["move", "left", "right", "derp", "report",                   \
                  "place 10, 10, north", "move", "place 0, 0, south", "right", \
                  "move", "right", "move", "place 4, 4, south", "move",        \
                  "move", "left", "move", "report", "exit"]

      allow(ToyRobot).to receive :print
      expect(ToyRobot).to receive(:gets).and_return(*commands)
      expect { ToyRobot.main }.to output(
        "Invalid command\nNo position\n4, 2, East\n",
      ).to_stdout
    end
  end
end
