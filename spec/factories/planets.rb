FactoryGirl.define do
  factory :planet do
    association :system
    association :user, factory: :user
    name { Faker::StarWars.planet }
  end

  factory :planet2 do
    association :system
    association :user2
    name { Faker::StarWars.planet }
  end

  trait :metal do
    metal 10000
  end

  trait :crystal do
    crystal 10000
  end

  trait :hydrogen do
    hydrogen 10000
  end

  trait :energy do
    energy 100
  end
end
