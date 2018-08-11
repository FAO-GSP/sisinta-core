# General methods and helpers for factories

FactoryBot.define do
  sequence(:email) { |n| "email-#{n}@example.com" }
end
