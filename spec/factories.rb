FactoryGirl.define do
  factory :client do
  end

  factory :robot do
  end

  factory :arena do
    initialize_with { new width: 5, height: 5 }
  end

  factory :null_arena do
  end

  factory :real_position do
    x_coord   { rand(0...5) }
    y_coord   { rand(0...5) }
    direction { %i(n e s w).sample }

    factory :real_position_with_arena do
      association :arena, strategy: :build
    end
  end

  factory :null_position do
  end

  factory :place_command do
    association :robot, strategy: :build
    association :arena, strategy: :build

    factory :place_command_with_inbounds_params do
      command = "place 0, 0, n"
      initialize_with { new robot: robot, arena: arena, command: command }
    end

    factory :place_command_with_out_of_bounds_params do
      command = "place 100, 100, n"
      initialize_with { new robot: robot, arena: arena, command: command }
    end
  end

  factory :move_command do
    association :robot, strategy: :build
    initialize_with { new robot: robot }
  end

  factory :left_command do
    association :robot, strategy: :build
    initialize_with { new robot: robot }
  end

  factory :right_command do
    association :robot, strategy: :build
    initialize_with { new robot: robot }
  end

  factory :report_command do
    association :robot, strategy: :build
    initialize_with { new robot: robot }
  end

  factory :invalid_command do
  end
end
