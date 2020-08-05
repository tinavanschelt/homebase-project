require "faker"

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    dob { "01/01/2000" }
    password { "Password1!" }
  end

  factory :group do
    title { Faker::Lorem.word }
    group_type { 0 }
    access_code { "1234abcd" }
  end
end
