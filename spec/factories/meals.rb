FactoryGirl.define do
  factory :salad, class: Meal do
    description "Caesar salad"
    day { 1.day.ago }
    hour { 1.hour.ago }
    calories 250
  end
  factory :soup, class: Meal do
    description "Chicken soup"
    day { 1.week.ago }
    hour { 1.minute.ago }
    calories 300
  end
end
