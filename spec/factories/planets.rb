FactoryGirl.define do
  factory :planet do
    association :system
    association :user, factory: :user
    name { Faker::StarWars.planet }
    metal_lvl 1
    crystal_lvl 1
    hydrogen_lvl 1
    solar_lvl 1
    energy 1
    metal 1
    crystal 1
    hydrogen 1
    metal_rdy_at Time.now
    crystal_rdy_at Time.now
    hydrogen_rdy_at Time.now
    solar_rdy_at Time.now
    resources_updated_at Time.now
  end

  factory :planet2 do
    association :system
    association :user2
    name { Faker::StarWars.planet }
    metal_lvl 1
    crystal_lvl 1
    hydrogen_lvl 1
    solar_lvl 1
    metal_rdy_at Time.now
    crystal_rdy_at Time.now
    hydrogen_rdy_at Time.now
    solar_rdy_at Time.now
    resources_updated_at Time.now
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
