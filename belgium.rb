BELGIAN_CITIES = [
  :bruges, :antwerp, :ghent, :mechelen, :brussels, :mons, :namur, :liege,
  :arlon, :tournai
]

BELGIAN_ROADS = {
  [:bruges, :ghent] => 50,
  [:ghent, :tournai] => 80,
  [:tournai, :brussels] => 89,
  [:ghent, :brussels] => 56,
  [:ghent, :antwerp] => 60,
  [:antwerp, :mechelen] => 25,
  [:mechelen, :brussels] => 27,
  [:brussels, :mons] => 80,
  [:mons, :namur] => 91,
  [:mons, :tournai] => 51,
  [:namur, :arlon] => 129,
  [:arlon, :liege] => 123,
  [:liege, :namur] => 65,
  [:liege, :brussels] => 97
}

class Country
  attr_accessor :name, :cities, :roads

  def self.belgium
    Country.new(:belgium).tap do |belgium|
      BELGIAN_CITIES.each { |city_name| belgium.build_city(city_name) }

      BELGIAN_ROADS.each do |(city_1, city_2), distance|
        belgium.build_road(
          belgium.find_city(city_1),
          belgium.find_city(city_2),
          distance
        )
      end
    end
  end

  def initialize(name)
    @name = name
    @cities = {}
    @roads = []
  end

  def build_city(name)
    @cities[name] = City.new(name)
  end

  def find_city(name)
    @cities[name] || raise("City: #{name} not found")
  end

  def build_road(city_1, city_2, distance)
    road = Road.new(city_1, city_2, distance)

    @roads << road

    city_1.add_road(road)
    city_2.add_road(road)
  end

  def to_s
    country_string = ""
    @cities.values.each do |city|
      country_string << "Roads from: #{city.name.capitalize} \n"
      city.roads.each do |road|
        country_string << "  - #{road.destination(city).name.capitalize}: #{road.distance} \n"
      end
    end
    country_string
  end

  def shortest_distance_between(start, target)
    current_city = self.find_city(start)
    target_city = self.find_city(target)

    visited = []
    unvisited = @cities.values

    # init tentative_distances
    tentative_distances = {}
    unvisited.each { |c| tentative_distances[c] = 100000 }
    tentative_distances[current_city] = 0

    while current_city != target_city
      current_city.neighbors.each do |neighbor|
        distance = current_city.road_to(neighbor)&.distance
        next if distance.nil?

        full_distance = distance + tentative_distances[current_city]
        tentative_distances[neighbor] = full_distance if full_distance < tentative_distances[neighbor]
      end

      # update visited nodes
      unvisited = unvisited - [current_city]
      visited << current_city

      # Find the city with the smallest tentative value
      current_city = tentative_distances.reject { |k, _| visited.include?(k) }.min_by{|k, v| v}.first
    end

    tentative_distances[target_city]
  end
end

class City
  attr_accessor :name, :roads

  def initialize(name)
    @name = name
    @roads = []
  end

  def add_road(road)
    @roads << road
  end

  def road_to(neighbor)
    @roads.detect { |road| road.destination(self) == neighbor }
  end

  def neighbors
    @roads.map(&:cities).flatten.uniq - [self]
  end
end

class Road
  attr_accessor :distance, :cities

  def initialize(city_1, city_2, distance)
    @cities = [city_1, city_2]
    @distance = distance
  end

  def destination(start_city)
    (@cities - [start_city]).first
  end
end

belgium = Country.belgium

puts "Shortest distance between Bruges and Liege: #{belgium.shortest_distance_between(:bruges, :liege)}"
puts "Shortest distance between Mons and Liege: #{belgium.shortest_distance_between(:mons, :liege)}"
puts "Shortest distance between Mons and Brussels: #{belgium.shortest_distance_between(:mons, :brussels)}"
puts "Shortest distance between Ghent and Arlon: #{belgium.shortest_distance_between(:ghent, :arlon)}"
puts "Shortest distance between Arlon and Ghent: #{belgium.shortest_distance_between(:arlon, :ghent)}"
puts "Shortest distance between Antwerp and tournai: #{belgium.shortest_distance_between(:antwerp, :tournai)}"
