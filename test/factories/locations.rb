FactoryBot.define do
  factory :location do
    profile

    trait :geolocated do
      coordinates { Location.factory.point rand(-180..180), rand(-85..85) }
    end
  end
end
