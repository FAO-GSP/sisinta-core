FactoryBot.define do
  factory :profile do
    association :user, :confirmed
    # Only create one ProfileType by default.
    type { ProfileType.default || create(:profile_type) }
    # Only create one License by default.
    license { License.default || create(:license) }
    source { generate :unique_string }
    country_code { (Rails.configuration.engine.default_country_codes - ['ANT']).sample }

    transient do
      layers_count { 0 }
    end

    after(:build) do |profile, evaluator|
      create_list :layer, evaluator.layers_count, profile: profile
    end

    # Every attribute and association initialized.
    trait :complete do
      association :location, :geolocated
      date { Date.yesterday }
      public { false }
      identifier { generate :unique_string }
      order { generate :unique_string }
      contact { generate :unique_string }

      transient do
        layers_count { 2 }
      end
    end
  end
end
