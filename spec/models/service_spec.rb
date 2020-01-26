require 'rails_helper'

RSpec.describe Service, type: :model do
  it { is_expected.to have_many(:regions) }
  it { is_expected.to validate_uniqueness_of(:code) }
  it { is_expected.to validate_presence_of(:code) }
end
