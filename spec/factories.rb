FactoryGirl.define do
  factory :client do
  end

  factory :input do
    factory :input_with_valid_command do
      initialize_with { new ["move", "left", "right", "report"].sample }
    end

    factory :input_with_invalid_command do
      initialize_with { new "derp" }
    end

    factory :input_place_with_valid_params do
      initialize_with { new "place 0, 0, n" }
    end

    factory :input_place_with_invalid_params do
      initialize_with { new "place derp" }
    end
  end

  factory :robot do
    association :arena, strategy: :build
    initialize_with { new arena: arena }

    factory :robot_in_position do
      association :position, strategy: :build
    end
  end

  factory :arena do
    initialize_with { new width: 5, height: 5 }
  end

  factory :position do
  end

  factory :null_position do
  end

  factory :place_command do
    association :robot, strategy: :build

    factory :place_command_with_valid_params do
      association :input_place_with_valid_params, strategy: :build

      initialize_with do
        new target: robot, params: input_place_with_valid_params.params
      end
    end

    factory :place_command_with_invalid_params do
      association :input_place_with_invalid_params, strategy: :build

      initialize_with do
        new target: robot, params: input_place_with_invalid_params.params
      end
    end
  end

  factory :move_command do
    association :robot, strategy: :build
    association :input_with_valid_command, strategy: :build

    initialize_with do
      new target: robot, params: input_with_valid_command.params
    end
  end

  factory :left_command do
    association :robot, strategy: :build
    association :input_with_valid_command, strategy: :build

    initialize_with do
      new target: robot, params: input_with_valid_command.params
    end
  end

  factory :right_command do
    association :robot, strategy: :build
    association :input_with_valid_command, strategy: :build

    initialize_with do
      new target: robot, params: input_with_valid_command.params
    end
  end

  factory :report_command do
    association :robot, strategy: :build
    association :input_with_valid_command, strategy: :build

    initialize_with do
      new target: robot, params: input_with_valid_command.params
    end
  end

  factory :invalid_command do
  end
end
