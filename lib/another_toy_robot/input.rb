# frozen_string_literal: true

require 'another_toy_robot/move_command'
require 'another_toy_robot/left_command'
require 'another_toy_robot/right_command'
require 'another_toy_robot/place_command'
require 'another_toy_robot/report_command'
require 'another_toy_robot/invalid_command'

class Input
  VALID_COMMANDS = {
    move: MoveCommand,
    left: LeftCommand,
    right: RightCommand,
    place: PlaceCommand,
    report: ReportCommand
  }.freeze

  def initialize(input)
    @input = input.strip.downcase
  end

  def params
    @params ||= @input.split(' ').drop 1
  end

  def to_class
    command_name = @input.split(' ').first
    VALID_COMMANDS.fetch(command_name.to_sym, InvalidCommand)
  end
end
