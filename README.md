# Dijkstra
Ruby on Rails project using Dijkstra's algorithm

## Specifications
By creating a new Rails app that you will call Dijkstra, I would like you to:
- Find a DB modelization that allows you to store any country given its cities and its roads between them (see Belgian graph);
- Store the Belgian data (see [belgium.rb](belgium.rb));
- Allow a user to select Belgium as a country (or if he/she navigates to /countries/belgium), then allow to select a starting point (a Belgian city) and a destination (also a Belgian city);
- Once the user has selected the starting point and the destination, tell the shortest distance between those two cities;
- Describe to the user the path (for example: Bruges -> Ghent -> Brussels -> Liège) that corresponds to the shortest distance you returned to the user;
- Make your code shines!

### Test and code comprehension
> CODE PLAYGROUND : [belgium.rb](https://code.sololearn.com/cIL8G5BYJvyu)

![Dijkstra DB modelization schema](DBModel75.png "Dijkstra DB modelization schema")

### Active Record Associations
- a Country has many Cities
- a City belongs to a Country
- a City has many Roads
- a Road has many Cities (always 2)

#### Scenario I
> irreversible action

When a City is `destroyed` > all depended roads should be `destroyed` too
<br>
When a Road is `destroyed` > only the specific road should be `destroyed`

#### Scenario II
> safer solution

When a City is `destroyed` > all depended roads should be `archived` and no more available but should still be `edited` and `reestablished`
<br>
<br>
When a Road is `destroyed` > only the specific road should be `archived` and no more available but should still be `edited` and `reestablished`
