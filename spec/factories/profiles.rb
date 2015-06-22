FactoryGirl.define do
  factory :normal_profile, class: Profile do
    role "normal"
    name "John Smith"
    calories_limit 500
  end
  factory :manager_profile, class: Profile do
    role "manager"
    name "John Smith"
    calories_limit 200
  end
  factory :admin_profile, class: Profile do
    role "admin"
    name "John Smith"
    calories_limit 200
  end

end
