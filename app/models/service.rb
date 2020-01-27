class Service < ApplicationRecord
  has_many :regions, dependent: :destroy
  validates :code, presence: true, uniqueness: true

  def self.fetch_and_save_records
    DataFetchManager.fetch_and_save
  end
end
