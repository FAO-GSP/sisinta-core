FactoryBot.define do
  factory :metadata_type do
    field_name { generate :unique_string }
    value { generate :unique_string }
  end
end
