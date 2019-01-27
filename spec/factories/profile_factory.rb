FactoryBot.define do
  factory :profile do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "password" }
  end
end
