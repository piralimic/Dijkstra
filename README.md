# Dijkstra
Ruby on Rails project using Dijkstra's algorithm

<img src="DBModel.png" width="48" alt="Dijkstra DB modelization schema" title="Dijkstra DB modelization schema" width="75%">

### Active Record Associations
- a Country has many Cities
- a City belongs to a Country
- a City has many Roads
- a Road has many Cities (always 2)
<br>
When a City is `destroyed` > all depended roads should be `destroyed` too
When a Road is `destroyed` > only the specific road should be `destroyed`
