FactoryGirl.define do
  factory :client

  factory :input do
    initialize_with { new "string" }

    factory :input_move do
      initialize_with { new "move" }
    end

    factory :input_left do
      initialize_with { new "left" }
    end

    factory :input_right do
      initialize_with { new "right" }
    end

    factory :input_report do
      initialize_with { new "report" }
    end

    factory :input_place do
      initialize_with { new "place 0, 0, n" }
    end

    factory :input_derp do
      initialize_with { new "derp" }
    end
  end

  factory :robot, aliases: [:robot_in_null_position] do
    factory :robot_in_position do
      association :position, strategy: :build
      initialize_with { new position: position }
    end
  end

  factory :arena
  factory :position
  factory :null_position
  factory :place_command
  factory :move_command
  factory :left_command
  factory :right_command
  factory :report_command
  factory :invalid_command
end
