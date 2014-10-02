# Read about factories at https://github.com/thoughtbot/factory_girl

require 'ffaker'

FactoryGirl.define do
  factory :signature do
    name Faker::Name.first_name
    role Faker::Company.name
    email Faker::Internet.email
  end
end
