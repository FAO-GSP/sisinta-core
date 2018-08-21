# User factory methods

FactoryBot.define do
  # Minimal requirements for validation
  factory :user do
    email
    password { 'correct horse battery staple' }

    factory :admin do
      admin { true }
    end
  end
end
