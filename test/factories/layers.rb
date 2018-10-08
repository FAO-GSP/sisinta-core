FactoryBot.define do
  factory :layer do
    profile
    identifier { generate :unique_string }
    top { rand(10) }
    bottom { 10 + rand(10) }

    # Every attribute and association initialized
    trait :complete do
      designation { generate :unique_string }
      bulk_density { rand * 100 }
      ca_co3 { rand * 100 }
      coarse_fragments { rand * 100 }
      ecec { rand * 100 }
      conductivity { rand * 100 }
      organic_carbon { rand * 100 }
      ph_h2o { rand * 100 }
      ph_kcl { rand * 100 }
      clay { rand * 100 }
      silt { rand * 100 }
      sand { rand * 100 }
      water_retention { rand * 100 }
    end
  end
end
