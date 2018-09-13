FactoryBot.define do
  factory :profile do
    association :user, :confirmed
    # Only create one ProfileType by default
    type { ProfileType.default || create(:profile_type) }
    # Only create one License by default
    license { License.default || create(:license) }
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
