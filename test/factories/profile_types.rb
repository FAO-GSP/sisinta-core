FactoryBot.define do
  factory :profile_type do
    value { generate :unique_string }
    # Only make the first one default by default
    default { ProfileType.all.empty? }
  end
end
