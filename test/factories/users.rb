# User factory methods

FactoryBot.define do
  # Minimal requirements for validation
  factory :user do
    email
    name { generate :unique_string }
    password { 'correct horse battery staple' }

    factory :admin do
      admin { true }
    end
  end
end
