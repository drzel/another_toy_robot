FactoryGirl.define do
  factory :robot do
  end

  factory :arena do
    initialize_with { new width: 5, height: 5 }
  end

  factory :null_arena do
  end

  factory :real_position do
    x         { rand(0...5) }
    y         { rand(0...5) }
    direction { %i(n e s w).sample }

    factory :real_position_with_arena do
      association :arena, strategy: :build
    end
  end

  factory :null_position do
  end

  factory :command do
    initialize_with { new command: %w(move left right report derp) }

    factory :invalid_command do
      initialize_with { new command: "derp" }
    end

    factory :move_command do
      initialize_with { new command: "move" }
    end

    factory :left_command do
      initialize_with { new command: "left" }
    end

    factory :right_command do
      initialize_with { new command: "right" }
    end

    factory :report_command do
      initialize_with { new command: "report" }
    end

    factory :place_command do
      initialize_with { new command: "place #{rand 0...5}, #{rand 0...5}, #{%w(n e s w)}" }
    end
  end
end
