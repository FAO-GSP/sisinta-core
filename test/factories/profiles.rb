FactoryBot.define do
  factory :profile do
    user

    # Every attribute and association initialized
    trait :complete do
      date { Date.yesterday }
      public { false }
      user_profile_id { generate :unique_string }
      order { generate :unique_string }
    end
  end
end
