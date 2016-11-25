FactoryGirl.define do
  factory :position do
    x         { rand 0...5 }
    y         { rand 0...5 }
    direction { %i(n e s w).sample }
  end

  factory :robot do
  end

  factory :arena do
    initialize_with { new width: 5, height: 5 }
  end

  factory :null_arena do
  end

  factory :real_position do
  end

  factory :null_position do
  end
end
