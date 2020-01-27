class Region < ApplicationRecord
  belongs_to :service
  has_many :products, dependent: :destroy
  validates :location, presence: true
end
