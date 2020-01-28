FactoryBot.define do
  factory :region do
    location { "Europe" }
    location_type { "AWS Edge Location" }
    service { nil }
  end
end
