# Dijkstra
Ruby on Rails project using Dijkstra's algorithm

## DB modelization
### Models
- Country :
<<<<<<< HEAD
  - id, name, cities
- City :
  - id, name, country, roads
- Road :
  - id, distance, start, destination
=======
 - - id, name, cities
- City :
 - - id, name, country, roads
- Road :
 - - id, distance, start, destination
>>>>>>> c73fb9f15fe133a595caf2d1ef45a44ca7e59fa9

### Active Record Associations
- a country has many cities
- a city belongs to a country
- a city has many roads
- a road belongs to a city (start OR destination)
