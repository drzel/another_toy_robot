# frozen_string_literal: true

require 'another_toy_robot/move_command'
require 'another_toy_robot/left_command'
require 'another_toy_robot/right_command'
require 'another_toy_robot/place_command'
require 'another_toy_robot/report_command'
require 'another_toy_robot/invalid_command'

class Input
  attr_reader :params

  VALID_COMMANDS = {
    move: MoveCommand,
    left: LeftCommand,
    right: RightCommand,
    place: PlaceCommand,
    report: ReportCommand
  }.freeze

  def initialize(input)
    @command_name, *@params = input.strip.downcase.split(' ')
  end

  def to_class
    VALID_COMMANDS.fetch(@command_name.to_sym, InvalidCommand)
  end
end
