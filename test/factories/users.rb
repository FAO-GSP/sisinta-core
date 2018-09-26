# User factory methods

FactoryBot.define do
  # Minimal requirements for validation
  factory :user do
    email
    name { generate :unique_string }
    password { 'correct horse battery staple' }

    factory :admin do
      role { :admin }
    end

    # Users need to be confirmed to log-in
    trait :confirmed do
      confirmed_at { Date.yesterday }
    end
  end
end
