FactoryBot.define do
  factory :metadata_type do
    field_name { MetadataType::FIELD_NAMES.sample }
    value { generate :unique_string }
  end
end
