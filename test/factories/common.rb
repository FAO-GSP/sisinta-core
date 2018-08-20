# General methods and helpers for factories

FactoryBot.define do
  # For any random string needed
  sequence :unique_string, 'a'

  # Random emails
  sequence(:email) do |n|
    "email-#{n}@example.com"
  end
end
