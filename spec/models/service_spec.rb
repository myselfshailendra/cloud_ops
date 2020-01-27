require 'rails_helper'

RSpec.describe Service, type: :model do
  it { is_expected.to have_many(:regions).dependent(:destroy) }
  it { is_expected.to validate_uniqueness_of(:code) }
  it { is_expected.to validate_presence_of(:code) }

  let(:aws_url) { 'https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/AmazonCloudFront/current/index.json' }
  let(:records) do
    {
        "formatVersion" => "v1.0",
        "disclaimer" => "This pricing list is for informational purposes only. All prices are subject to the additional terms included in the pricing pages on http://aws.amazon.com. All Free Tier prices are also subject to the terms included at https://aws.amazon.com/free/",
        "offerCode" => "AmazonCloudFront",
        "version" => "20191219230750",
        "publicationDate" => "2019-12-19T23:07:50Z",
        "products" => {
            "RN2BPS8XT2GYJ4UF" => {
                "sku" => "RN2BPS8XT2GYJ4UF",
                "productFamily" => "Serverless",
                "attributes" => {
                    "servicecode" => "AmazonCloudFront",
                    "location" => "EU (Paris)",
                    "locationType" => "AWS Region",
                    "group" => "AWS-Lambda-Edge-Requests",
                    "groupDescription" => "Invocation call for a Lambda function",
                    "usagetype" => "EUW3-Lambda-Edge-Request",
                    "operation" => "",
                    "servicename" => "Amazon CloudFront"
                }
            }
        },
        "terms" => {
            "OnDemand" => {
                "RN2BPS8XT2GYJ4UF" => {
                    "RN2BPS8XT2GYJ4UF.JRTCKXETXF" => {
                        "offerTermCode" => "JRTCKXETXF",
                        "sku" => "RN2BPS8XT2GYJ4UF",
                        "effectiveDate" => "2019-12-01T00:00:00Z",
                        "priceDimensions" => {
                            "RN2BPS8XT2GYJ4UF.JRTCKXETXF.6YS6EN2CT7" => {
                                "rateCode" => "RN2BPS8XT2GYJ4UF.JRTCKXETXF.6YS6EN2CT7",
                                "description" => "$6.0E-7  per Request for Lambda-Edge-Request in EU (Paris)",
                                "beginRange" => "0",
                                "endRange" => "Inf",
                                "unit" => "Request",
                                "pricePerUnit" => {
                                    "USD" => "0.0000006000"
                                },
                                "appliesTo" => [

                                ]
                            }
                        },
                        "termAttributes" => {
                        }
                    }
                }
            }
        }
    }
  end

  describe '#fetch_and_save_records' do
    before do
      allow(DataFetchManager).to receive(:fetch_data).and_return(records)
      Service.fetch_and_save_records
    end

    it 'creates records' do
      expect(Service.count).to eq(1)
      expect(Region.count).to eq(1)
      expect(Product.count).to eq(1)
      expect(Product.last.sku).to eq('RN2BPS8XT2GYJ4UF')
    end
  end
end
