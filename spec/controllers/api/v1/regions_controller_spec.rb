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
            effective_date: "2019-12-03 00:00:00",
            usage_type: "UGE1-Lambda-Edge-Request"
  end

  describe 'GET #show_region_prices' do
    context 'without date filter' do
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

      context 'when both found and products exists' do
        let(:service_code) { service.code }
        let(:location) { region.location }

        it { expect(JSON.parse(response.body).length).to eq(2) }
        it { expect(response.status).to eq(200) }
      end
    end

    context 'with date filter' do
      before do
        get :show_region_prices, params: { service_code: service.code, location: region.location, date: date }, format: :json
      end

      context 'when provide invalid date' do
        let(:date) { 'WrongFormat' }

        it { expect(JSON.parse(response.body)).to eq({"errors"=>{"base"=>"Invalid date param."}}) }
        it { expect(response.status).to eq(422) }
      end

      context 'when provide valid date and products exist' do
        let(:date) { '03-12-2019' }

        it { expect(JSON.parse(response.body).length).to eq(1) }
        it { expect(JSON.parse(response.body).first['description']).to eq(product2.description) }
        it { expect(response.status).to eq(200) }
      end

      context 'when provide valid date and products do not exist' do
        let(:date) { '02-12-3019' }

        it { expect(JSON.parse(response.body)).to eq([]) }
        it { expect(response.status).to eq(200) }
      end
    end
  end
end