class DataFetchManager
  AWS_URL = 'https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/AmazonCloudFront/current/index.json'

  def self.fetch_and_save
    records = fetch_data
    save_data(records)
  end

  def self.save_data(records)
    records['products'].zip(records['terms']['OnDemand']).each do |product, on_demand|
      service = Service.find_or_create_by(service_attributes(product))
      region = service.regions.find_or_create_by(region_attributes(product))
      unless region.products.find_by(sku: product.first)
        region.products.create(product_attributes(product, on_demand))
      end
    end
  end

  def self.service_attributes(product)
    { name: product.last['attributes']['servicename'], code: product.last['attributes']['servicecode'] }
  end

  def self.region_attributes(product)
    { location: product.last['attributes']['location'] || product.last['attributes']['fromLocation'] || 'unknown',
      location_type: product.last['attributes']['locationType'] || product.last['attributes']['fromLocationType'] || 'unknown' }
  end

  def self.product_attributes(product, on_demand)
    priceDimensionsValues = on_demand.last.values.first['priceDimensions'].values.first
    {
        offer_term_code: on_demand.last.values.first['offerTermCode'],
        sku: product.first,
        product_family: product.last['productFamily'],
        description: priceDimensionsValues['description'],
        begin_range: priceDimensionsValues['beginRange'],
        end_range: priceDimensionsValues['endRange'],
        unit: priceDimensionsValues['unit'],
        price_per_unit: priceDimensionsValues['pricePerUnit']['USD'],
        effective_date: on_demand.last.values.first['effectiveDate'],
        usage_type: product.last['attributes']['usagetype']
    }
  end

  def self.fetch_data
    begin
      response = HTTParty.get(AWS_URL)
      if response.success?
        records = JSON.parse(response.body)
        return records
      end
    rescue HTTParty::Error, SocketError => e
      Rails.logger.info("Error connecting to RedCap - #{e.message}")
    end
  end
end