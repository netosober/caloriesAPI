FactoryGirl.define do

  factory :normal, class: User do |u|
    email "user@example.com"
    password "password"
    password_confirmation "password"
    role :normal
  end

  factory :other, class: User do |u|
    email "user2@example.com"
    password "password"
    password_confirmation "password"
    role :normal
  end

  factory :manager, class: User do |u|
    email "manager@example.com"
    password "password"
    password_confirmation "password"
    role :manager
  end

  factory :admin, class: User do |u|
    email "admin@example.com"
    password "password"
    password_confirmation "password"
    role :admin
  end

  factory :user do
    email "abc@def.com"
    password  "password"
    password_confirmation "password"
    role :normal
  end


end
