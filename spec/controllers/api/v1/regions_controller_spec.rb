require "rails_helper"

RSpec.describe Api::V1::RegionsController, type: :controller do
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
            effective_date: "2019-12-02 00:00:00",
            usage_type: "UGE1-Lambda-Edge-Request"
  end

  describe 'GET #show_region_prices' do
    before do
      get :show_region_prices, params: { service_code: service_code, location: location }, format: :json
    end

    context 'when service not found' do
      let(:service_code) { 'WrongCode' }
      let(:location) { region.location }
      it { expect(JSON.parse(response.body)).to eq({"errors"=>{"base"=>"Service not found."}}) }
      it { expect(response.status).to eq(404) }
    end

    context 'when region not found' do
      let(:service_code) { service.code }
      let(:location) { 'WrongRegion' }
      it { expect(JSON.parse(response.body)).to eq({"errors"=>{"base"=>"Region not found."}}) }
      it { expect(response.status).to eq(404) }
    end

    context 'when both created with products' do
      let(:service_code) { service.code }
      let(:location) { region.location }
      it { expect(JSON.parse(response.body).length).to eq(2) }
      it { expect(response.status).to eq(200) }
    end
  end
end