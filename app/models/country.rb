class Country < ApplicationRecord
  has_many :cities, dependent: :destroy
  has_many :from_ways, through: :cities
  validates :name, presence: true
end
