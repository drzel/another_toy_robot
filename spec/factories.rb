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
end
