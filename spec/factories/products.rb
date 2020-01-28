FactoryBot.define do
  factory :product do
    offer_term_code { "JRTCKXETXF" }
    sku { "XD7ZDAECJ2BPHRKJ" }
    product_family { "Request" }
    description { "$0.0090 per 10,000 Proxy HTTP Requests (Europe)" }
    begin_range { 0 }
    end_range { 0 }
    unit { "Requests" }
    price_per_unit { "0.0000009000" }
    effective_date { "2019-12-01 00:00:00" }
    usage_type { "EU-Requests-HTTP-Proxy" }
    region { nil }
  end
end