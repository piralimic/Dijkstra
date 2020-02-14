class City < ApplicationRecord
  belongs_to :country
  has_many :from_ways, class_name: "Way", foreign_key: "city_from_id"
  has_many :to_ways, class_name: "Way", foreign_key: "city_to_id"
  validates :name, presence: true
end
