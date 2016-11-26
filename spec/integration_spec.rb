require "spec_helper"

describe "integration tests" do
  let(:client) { build :client }

  describe "Example a) 'place 0, 0, n' 'move' 'report'" do
    commands = ["place 0, 0, n", "move", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it 'outputs "0, 1, n"' do
      expect { user_input }.to output("0, 1, n\n").to_stdout
    end
  end

  describe "Example b) 'place 0, 0, n' 'left' 'report'" do
    commands = ["place 0, 0, n", "left", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it 'outputs "0, 0, w"' do
      expect { user_input }.to output("0, 0, w\n").to_stdout
    end
  end

  describe "Example c) 'place 1, 2, e' 'move' 'move' 'left' 'move' 'report'" do
    commands = ["place 1, 2, e", "move", "move", "left", "move", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it 'outputs "3, 3, n"' do
      expect { user_input }.to output("3, 3, n\n").to_stdout
    end
  end

  describe "place, rotate, move and report with valid positions" do
    commands = ["place 0, 0, n", "right", "move", "move", "left", "move",
                "move", "right", "move", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it "reports position" do
      expect { user_input }.to output("3, 2, e\n").to_stdout
    end
  end

  describe "try to move out of bounds" do
    commands = ["place 4, 3, n", "move", "move", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it "ignores command, reports last inbounds position" do
      expect { user_input }.to output("4, 4, n\n").to_stdout
    end
  end

  describe "place robot in out of bounds position" do
    commands = ["place 10, 10, n", "report"]
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
    commands = ["place 0, 0, n", "place 2, 2, s", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it "reports the new position" do
      expect { user_input }.to output("2, 2, s\n").to_stdout
    end
  end

  describe "catch all" do
    commands = ["move", "left", "right", "derp", "report", "place 10, 10, n", \
                "move", "place 0, 0, s", "right", "move", "right", "move",    \
                "place 4, 4, s", "move", "move", "left", "move", "report"]
    let(:user_input) { commands.each { |command| client.instruction command } }

    it "ignores command to walk off the edge" do
      expect { user_input }.to output(
        "Invalid command\nNo position\n4, 2, e\n",
      ).to_stdout
    end
  end
end
