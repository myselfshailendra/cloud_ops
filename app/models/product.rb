class Product < ApplicationRecord
  belongs_to :region
  validates :sku, presence: true, uniqueness: true

  scope :filter_with_date, -> (date) { where(effective_date: date) }
end
