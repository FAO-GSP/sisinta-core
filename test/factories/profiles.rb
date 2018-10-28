FactoryBot.define do
  factory :profile do
    association :user, :confirmed
    # Only create one ProfileType by default
    type { ProfileType.default || create(:profile_type) }
    # Only create one License by default
    license { License.default || create(:license) }
    source { generate :unique_string }
    country_code { Rails.configuration.engine.default_country_codes.sample }
  end
end
