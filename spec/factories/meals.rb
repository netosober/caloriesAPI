FactoryGirl.define do
  factory :meal do
    description "Caesar salad"
    day { 1.day.ago }
    hour { 1.hour.ago }
    calories 250
  end
end
