FactoryGirl.define do
  factory :user do
    email "user@private-events.com"
    password "supersecret"
    password_confirmation "supersecret"
  end

  factory :invalid_user, class: :user do
    email "fakemail"
    password "supersecret"
    password_confirmation "supersecret"
  end
end
