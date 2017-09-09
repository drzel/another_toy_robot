FactoryGirl.define do
  factory :client

  factory :command_delegator do
    initialize_with { new(robot, basename) }
    association :robot, strategy: :build
    basename "report"
  end

  factory :input do
    basename "report"
  end

  factory :robot, aliases: [:robot_in_null_position] do
    factory :robot_in_position do
      association :position, strategy: :build
      initialize_with { new position: position }
    end
  end

  factory :arena
  factory :null_arena

  factory :position do
    factory :out_of_bounds_position do
      initialize_with { new x_coord: 100 }
    end
  end

  factory :null_position
  factory :place_command
  factory :move_command
  factory :left_command
  factory :right_command
  factory :report_command
  factory :invalid_command
end
