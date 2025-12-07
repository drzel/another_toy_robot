# frozen_string_literal: true

describe AnotherToyRobot do
  it 'has a version number' do
    expect(AnotherToyRobot::VERSION).not_to be nil
  end

  describe '#main' do
    it 'creates a new instance of client' do
      expect(Client).to receive(:new)
      allow(AnotherToyRobot).to receive(:loop)
      AnotherToyRobot.main
    end

    it 'creates a new instance of input' do
      client_dbl = instance_double 'Client'
      input_dbl  = instance_double 'Input'
      allow(Client).to receive(:new) { client_dbl }
      allow(AnotherToyRobot).to receive :print
      allow(AnotherToyRobot).to receive(:gets).and_return "move\n", "exit\n"
      expect(Input).to receive(:new).with("move\n") { input_dbl }
      allow(client_dbl).to receive(:command_for).with input_dbl
      AnotherToyRobot.main
    end

    it 'sends command_for with input object to client' do
      client_dbl = instance_double 'Client'
      input_dbl  = instance_double 'Input'
      allow(Client).to receive(:new) { client_dbl }
      allow(AnotherToyRobot).to receive :print
      allow(AnotherToyRobot).to receive(:gets).and_return "move\n", "exit\n"
      allow(Input).to receive(:new).with("move\n") { input_dbl }
      expect(client_dbl).to receive(:command_for).with input_dbl
      AnotherToyRobot.main
    end
  end
end

describe 'Integration' do
  def unchomp(commands)
    commands.map { |command| "#{command}\n" }
  end

  describe "Example a) 'place 0, 0, north' 'move' 'report'" do
    it 'outputs "0, 1, North"' do
      commands = unchomp ['place 0, 0, north', 'move', 'report', 'exit']

      allow(AnotherToyRobot).to receive :print
      expect(AnotherToyRobot).to receive(:gets).and_return(*commands)
      expect { AnotherToyRobot.main }.to output("0, 1, North\n").to_stdout
    end
  end

  describe "Example b) 'place 0, 0, north' 'left' 'report'" do
    it 'outputs "0, 0, west"' do
      commands = unchomp ['place 0, 0, north', 'left', 'report', 'exit']

      allow(AnotherToyRobot).to receive :print
      expect(AnotherToyRobot).to receive(:gets).and_return(*commands)
      expect { AnotherToyRobot.main }.to output("0, 0, West\n").to_stdout
    end
  end

  describe "Example c) 'place 1, 2, east' 'move' 'move' 'left' 'move' " \
           "'report'" do
    it 'outputs "3, 3, north"' do
      commands = unchomp ['place 1, 2, east', 'move', 'move', 'left', 'move',
                          'report', 'exit']

      allow(AnotherToyRobot).to receive :print
      expect(AnotherToyRobot).to receive(:gets).and_return(*commands)
      expect { AnotherToyRobot.main }.to output("3, 3, North\n").to_stdout
    end
  end

  describe 'place, rotate, move and report with valid positions' do
    it 'reports position' do
      commands = unchomp ['place 0, 0, north', 'right', 'move', 'move', 'left',
                          'move', 'move', 'right', 'move', 'report', 'exit']

      allow(AnotherToyRobot).to receive :print
      expect(AnotherToyRobot).to receive(:gets).and_return(*commands)
      expect { AnotherToyRobot.main }.to output("3, 2, East\n").to_stdout
    end
  end

  describe 'try to move out of bounds' do
    it 'ignores command, reports last inbounds position' do
      commands = unchomp ['place 4, 3, north', 'move', 'move', 'report', 'exit']

      allow(AnotherToyRobot).to receive :print
      expect(AnotherToyRobot).to receive(:gets).and_return(*commands)
      expect { AnotherToyRobot.main }.to output("4, 4, North\n").to_stdout
    end
  end

  describe 'place robot in out of bounds position' do
    it 'ignores command, reports "No position"' do
      commands = unchomp ['place 10, 10, north', 'report', 'exit']

      allow(AnotherToyRobot).to receive :print
      expect(AnotherToyRobot).to receive(:gets).and_return(*commands)
      expect { AnotherToyRobot.main }.to output("No position\n").to_stdout
    end
  end

  describe 'move and rotate robot without placing in position' do
    it 'reports "No position"' do
      commands = unchomp %w[move left right report exit]

      allow(AnotherToyRobot).to receive :print
      expect(AnotherToyRobot).to receive(:gets).and_return(*commands)
      expect { AnotherToyRobot.main }.to output("No position\n").to_stdout
    end
  end

  describe 'input an invalid command' do
    it 'outputs "Invalid command"' do
      commands = unchomp %w[derp exit]

      allow(AnotherToyRobot).to receive :print
      expect(AnotherToyRobot).to receive(:gets).and_return(*commands)
      expect { AnotherToyRobot.main }.to output("Invalid command\n").to_stdout
    end
  end

  describe 'validly place an already validly placed robot' do
    it 'reports the new position' do
      commands = unchomp ['place 0, 0, north', 'place 2, 2, south', 'report',
                          'exit']

      allow(AnotherToyRobot).to receive :print
      expect(AnotherToyRobot).to receive(:gets).and_return(*commands)
      expect { AnotherToyRobot.main }.to output("2, 2, South\n").to_stdout
    end
  end

  describe 'catch all' do
    it 'does it all' do
      commands = unchomp ['move', 'left', 'right', 'derp', 'report',
                          'place 10, 10, north', 'move', 'place 0, 0, south',
                          'right', 'move', 'right', 'move', 'place 4, 4, south',
                          'move', 'move', 'left', 'move', 'report', 'exit']

      allow(AnotherToyRobot).to receive :print
      expect(AnotherToyRobot).to receive(:gets).and_return(*commands)
      expect { AnotherToyRobot.main }.to output(
        "Invalid command\nNo position\n4, 2, East\n"
      ).to_stdout
    end
  end
end
