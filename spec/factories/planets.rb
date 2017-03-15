FactoryGirl.define do
  factory :planet do
    name { Faker::StarWars.planet }
    user nil

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
end
