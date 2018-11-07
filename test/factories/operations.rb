FactoryBot.define do
  factory :operation do
    association :user, :confirmed
    name { generate :unique_string }
  end
end
