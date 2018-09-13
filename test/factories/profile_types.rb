FactoryBot.define do
  factory :profile_type do
    value { generate :unique_string }
  end
end
