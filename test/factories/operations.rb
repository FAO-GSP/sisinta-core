FactoryBot.define do
  factory :operation do
    association :user, :confirmed
    name { generate :unique_string }

    trait :with_results do
      after(:build) do |operation|
        operation.results.attach(
          io: SisintaTestHelpers.uploaded_file,
          filename: generate(:unique_string)
        )
      end
    end
  end
end
