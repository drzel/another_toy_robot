FactoryGirl.define do
  factory :position do
    x         { rand 0...5 }
    y         { rand 0...5 }
    direction { %i(n e s w).sample }
  end

  factory :robot do
  end
end
