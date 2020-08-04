require "faker"

FactoryBot.define do
  factory :user, aliases: [:source_account] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    dob { "01/01/2000" }
    password { "Password1!" }
  end
end
