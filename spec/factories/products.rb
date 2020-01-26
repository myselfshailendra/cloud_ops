FactoryBot.define do
  factory :product do
    offer_term_code { "MyString" }
    sku { "MyString" }
    product_family { "MyString" }
    description { "MyString" }
    begin_range { 1 }
    end_range { 1 }
    unit { "MyString" }
    price_per_unit { "MyString" }
    effective_date { "2020-01-27 03:55:22" }
    usage_type { "MyString" }
    region { nil }
  end
end
