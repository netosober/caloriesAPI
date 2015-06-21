FactoryGirl.define do

  factory :normal, class: User do |u|
    email "user@example.com"
    password "password"
    password_confirmation "password"
    role :normal
    name "Normal user"
    calories_limit 500
  end

  factory :other, class: User do |u|
    email "user2@example.com"
    password "password"
    password_confirmation "password"
    role :normal
    name "Other user"
    calories_limit 500
  end

  factory :manager, class: User do |u|
    email "manager@example.com"
    password "password"
    password_confirmation "password"
    role :manager
    name "Manager user"
    calories_limit 500
  end

  factory :admin, class: User do |u|
    email "admin@example.com"
    password "password"
    password_confirmation "password"
    role :admin
    name "Admin user"
    calories_limit 500
  end

  factory :user do
    email "abc@def.com"
    password  "password"
    password_confirmation "password"
    role :normal
    name "User"
    calories_limit 500
  end

end
