require "another_toy_robot/command"
require "another_toy_robot/commands/move_command"
require "another_toy_robot/commands/left_command"
require "another_toy_robot/commands/right_command"
require "another_toy_robot/commands/place_command"
require "another_toy_robot/commands/report_command"
require "another_toy_robot/commands/invalid_command"
require "another_toy_robot/commands/exit_command"

module CommandDelegator
  COMMANDS = { "move"   => MoveCommand,
               "left"   => LeftCommand,
               "right"  => RightCommand,
               "place"  => PlaceCommand,
               "report" => ReportCommand,
               "exit"   => ExitCommand }.freeze

  def self.build(basename:, **args)
    command = COMMANDS[basename] || InvalidCommand
    command.new args
  end
end
