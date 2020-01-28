require 'rails_helper'

RSpec.describe 'RegionsRoutes', type: :routing do
  describe 'GET #show_region_prices' do
    it { expect(get: 'api/v1/service/AmazonCloudFront/region/us-east-1').to route_to(controller: 'api/v1/regions',
                                                                                     action: 'show_region_prices',
                                                                                     service_code: 'AmazonCloudFront',
                                                                                     location: 'us-east-1') }
  end
end
