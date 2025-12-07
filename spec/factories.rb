FactoryBot.define do
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
    association :arena, strategy: :build
    initialize_with { new arena: arena }

    factory :robot_in_position do
      association :position, strategy: :build
      initialize_with { new arena: arena, position: position }
    end
  end

  factory :arena

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
