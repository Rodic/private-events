FactoryGirl.define do
  factory :event do
    date 1.week.from_now
    title "MyEvent"
    location "My place"
    description "Bring your drink"
  end
end
