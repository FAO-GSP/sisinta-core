FactoryBot.define do
  factory :license do
    name { generate :unique_string }
    url { generate :unique_string }
    acronym { generate :unique_string }
    statement { generate :unique_string }
    # Only make the first one default by default
    default { License.all.empty? }
  end
end
