FactoryGirl.define do

  factory :normalUser, class: User do |u|
    email "user@example.com"
    password "password"
    password_confirmation "password"
    role :normal
  end

  factory :managerUser, class: User do |u|
    email "manager@example.com" 
    password "password"
    password_confirmation "password"
    role :manager
  end

  factory :adminUser, class: User do |u|
    email "admin@example.com"
    password "password"
    password_confirmation "password"
    role :admin
  end

end
