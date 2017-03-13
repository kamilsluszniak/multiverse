FactoryGirl.define do
  factory :planet do
    name { Faker::StarWars.planet }
    user nil
  end
end
