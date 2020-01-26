class Product < ApplicationRecord
  belongs_to :region
  validates :sku, presence: true, uniqueness: true
end
