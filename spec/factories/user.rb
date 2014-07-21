FactoryGirl.define do
  factory :user  do
    email "example1@example.com"
    full_name "user1"
    password "simple_password"
    password_confirmation "simple_password"
  end
  factory :invalid_user, class: User do
    email ""
    full_name "user1"
    password "simple_password"
    password_confirmation "simple"
  end
  factory :admin, class: User do
    email "admin@example.com"
    full_name "admin1"
    password "password"
    password_confirmation "password"
  end
end
