require 'rails_helper'

RSpec.describe Region, type: :model do
  it { is_expected.to have_many(:products) }
  it { is_expected.to belong_to(:service) }
  it { is_expected.to validate_presence_of(:location) }
end
