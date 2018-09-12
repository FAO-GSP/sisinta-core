FactoryBot.define do
  factory :profile do
    user
    source { generate :unique_string }

    # Every attribute and association initialized
    trait :complete do
      date { Date.yesterday }
      public { false }
      identifier { generate :unique_string }
      order { generate :unique_string }
    end
  end
end
