require "spec_helper"

describe "Integration tests" do
  let(:client) { build :client }

  describe "Example a) 'place 0, 0, north' 'move' 'report'" do
    commands = ["place 0, 0, north", "move", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it 'outputs "0, 1, north"' do
      expect { user_input }.to output("0, 1, north\n").to_stdout
    end
  end

  describe "Example b) 'place 0, 0, north' 'left' 'report'" do
    commands = ["place 0, 0, north", "left", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it 'outputs "0, 0, west"' do
      expect { user_input }.to output("0, 0, west\n").to_stdout
    end
  end

  describe "Example c) 'place 1, 2, east' 'move' 'move' 'left' 'move' 'report'" do
    commands = ["place 1, 2, east", "move", "move", "left", "move", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it 'outputs "3, 3, north"' do
      expect { user_input }.to output("3, 3, north\n").to_stdout
    end
  end

  describe "place, rotate, move and report with valid positions" do
    commands = ["place 0, 0, north", "right", "move", "move", "left", "move",
                "move", "right", "move", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it "reports position" do
      expect { user_input }.to output("3, 2, east\n").to_stdout
    end
  end

  describe "try to move out of bounds" do
    commands = ["place 4, 3, north", "move", "move", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it "ignores command, reports last inbounds position" do
      expect { user_input }.to output("4, 4, north\n").to_stdout
    end
  end

  describe "place robot in out of bounds position" do
    commands = ["place 10, 10, north", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it 'ignores command, reports "No position"' do
      expect { user_input }.to output("No position\n").to_stdout
    end
  end

  describe "move and rotate robot without placing in position" do
    commands = ["move", "left", "right", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it 'reports "No position"' do
      expect { user_input }.to output("No position\n").to_stdout
    end
  end

  describe "input an invalid command" do
    commands = ["derp"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it 'outputs "Invalid command"' do
      expect { user_input }.to output("Invalid command\n").to_stdout
    end
  end

  describe "validly place an already validly placed robot" do
    commands = ["place 0, 0, north", "place 2, 2, south", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it "reports the new position" do
      expect { user_input }.to output("2, 2, south\n").to_stdout
    end
  end

  describe "catch all" do
    commands = ["move", "left", "right", "derp", "report",                    \
                "place 10, 10, north", "move", "place 0, 0, south", "right",  \
                "move", "right", "move", "place 4, 4, south", "move", "move", \
                "left", "move", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it "does it all" do
      expect { user_input }.to output(
        "Invalid command\nNo position\n4, 2, east\n",
      ).to_stdout
    end
  end
end
