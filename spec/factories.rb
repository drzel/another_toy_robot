FactoryGirl.define do
  factory :app do
    robot
  end

  factory :arena do
    initialize_with { new(5, 5) }
  end

  factory :command do
    robot
  end

  factory :position do
    x { rand 0...5 }
    y { rand 0...5 }
    direction { %i(n e s w).sample }
    
    initialize_with { new(attributes) }
  end

  factory :null_position do
  end

  factory :robot do
    association :arena, strategy: :build

    initialize_with { new(arena: arena) }

    factory :robot_with_position do
      association :position, strategy: :build

      initialize_with { new(arena: arena, position: position) }
    end
  end
end
