require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to belong_to(:region) }
  it { is_expected.to validate_presence_of(:sku) }

  let(:service) { FactoryBot.create :service }
  let(:region) { FactoryBot.create :region, service_id: service.id }
  let!(:product1) { FactoryBot.create :product, region_id: region.id }
  let!(:product2) do
    FactoryBot.create :product, region_id: region.id,
                      offer_term_code: "JRTCKXETXF",
                      sku: "CYHNW9MJYBF8UUJY",
                      product_family: "Serverless",
                      description: "$6.0E-7  per Request for Lambda-Edge-Request in AW",
                      begin_range: 0,
                      end_range: 0,
                      unit: "Request",
                      price_per_unit: "0.0000006000",
                      effective_date: "2019-12-03 00:00:00",
                      usage_type: "UGE1-Lambda-Edge-Request"
  end

  describe '#filter_with_date' do
    it { expect(Product.filter_with_date('03-12-2019').count).to eq(1) }
    it { expect(Product.filter_with_date('13-12-2019').count).to eq(0) }
  end
end
