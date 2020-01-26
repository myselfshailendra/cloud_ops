class Region < ApplicationRecord
  belongs_to :service
  has_many :products
  validates :location, presence: true
end
