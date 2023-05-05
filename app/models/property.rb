class Property < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :images
  has_one :address
  has_one :reservation_criteria
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :no_bedrooms, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :no_bathrooms, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :no_beds, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :area, presence: true, numericality: { greater_than_or_equal_to: 1 }
end