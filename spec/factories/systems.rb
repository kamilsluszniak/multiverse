FactoryGirl.define do
  sequence(:random_system_name) do
    @random_name = Array.new(5){[*"A".."Z", *"0".."9"].sample}.join
  end

  factory :system do
    name { FactoryGirl.generate(:random_system_name) }
    size 1
  end
end
