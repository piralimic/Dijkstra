# Dijkstra
Ruby on Rails project using Dijkstra's algorithm

## DB modelization
### Models
- Country :
 - - id, name, cities
- City :
 - - id, name, country, roads
- Road :
 - - id, distance, start, destination

### Active Record Associations
- a country has many cities
- a city belongs to a country
- a city has many roads
- a road belongs to a city (start OR destination)
