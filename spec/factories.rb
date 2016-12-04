FactoryGirl.define do
  factory :client

  factory :input do
    initialize_with { new "string" }
  end

  factory :robot
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
