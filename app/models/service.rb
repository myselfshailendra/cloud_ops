class Service < ApplicationRecord
  has_many :regions
  validates :code, presence: true, uniqueness: true
end
