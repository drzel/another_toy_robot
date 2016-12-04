FactoryGirl.define do
  factory :client do
  end

  factory :input do
    initialize_with { new "string" }
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
  end

  factory :move_command do
  end

  factory :left_command do
  end

  factory :right_command do
  end

  factory :report_command do
  end

  factory :invalid_command do
  end
end
