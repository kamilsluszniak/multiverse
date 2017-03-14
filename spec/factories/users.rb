FactoryGirl.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }
    encrypted_password { User.new.send(:password_digest, password) }
  end
end
