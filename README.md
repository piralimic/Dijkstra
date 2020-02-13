# Dijkstra
Ruby on Rails project using Dijkstra's algorithm

## Mockup
### Welcome Page
![Dijkstra Mockup welcome page](moq001.png "Dijkstra Mockup welcome page")
### Selected Country Page
![Dijkstra Mockup country page](moq002.png "Dijkstra Mockup country page")
### Algorithm Response
![Dijkstra Mockup result page](moq003.png "Dijkstra Mockup result page")

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

![Dijkstra DB modelization schema](DBModelv3.png "Dijkstra DB modelization schema")

### Active Record Associations
- a Country has many Cities
- a City belongs to a Country
- a City has many Ways
- a Way belongs to a City (`city_from_id` OR `city_to_id`)

#### Binding Scenario I
> Irreversible action

When a City is `destroyed` > all depended roads should be `destroyed` too
<br>
<br>
When a Road is `destroyed` > only the specific road should be `destroyed`

#### Binding Scenario II
> Safer solution

When a City is `destroyed` > all depended roads should be `archived` and no more available but should still be `edited` and `reestablished`
<br>
<br>
When a Road is `destroyed` > only the specific road should be `archived` and no more available but should still be `edited` and `reestablished`
<br>

## Algorithm explanation

### The shortest distance between Bruges and Liege

#### First Step
Initialize the distance as infinite from *source* city.
<br>
```Ruby
visited = []
unvisited = [:bruges,:ghent,:antwerp,:tournai,:mechelen,:brussels,:mons,:namur,:liege,:arlon]
```
![Shortest distance from Bruges](algo/graph00.png "Shortest distance from Bruges")
![Shortest distance values](algo/step00.png "Shortest distance from values")

#### Next Step : neighbors of Bruges
Only one neighbor, the distance is by default `saved` as the shortest distance.
<br>
```Ruby
visited = [:bruges]
unvisited = [:ghent,:antwerp,:tournai,:mechelen,:brussels,:mons,:namur,:liege,:arlon]
```
![Shortest distance from Bruges](algo/graph01.png "Shortest distance from Bruges")
![Shortest distance values](algo/step01.png "Shortest distance from values")

#### Next Step : neighbors of Ghent
Multiple paths, no previous distances to compare, all distances are `saved`.
<br>
```Ruby
visited = [:bruges,:ghent]
unvisited = [:antwerp,:tournai,:mechelen,:brussels,:mons,:namur,:liege,:arlon]
```
![Shortest distance from Bruges](algo/graph02.png "Shortest distance from Bruges")
![Shortest distance values](algo/step02.png "Shortest distance from values")

#### Next Step : neighbors of Brussels
Multiple paths, previous distances are compared, only shortest distances are `saved`.
<br>
```Ruby
visited = [:bruges,:ghent,:brussels]
unvisited = [:antwerp,:tournai,:mechelen,:mons,:namur,:liege,:arlon]
```
![Shortest distance from Bruges](algo/graph03.png "Shortest distance from Bruges")
![Shortest distance values](algo/step03.png "Shortest distance from values")

#### Next Step : neighbors of Antwerp
Multiple paths, previous distances are compared, only shortest distances are `saved`.
<br>
```Ruby
visited = [:bruges,:ghent,:brussels,:antwerp]
unvisited = [:tournai,:mechelen,:mons,:namur,:liege,:arlon]
```
![Shortest distance from Bruges](algo/graph04.png "Shortest distance from Bruges")
![Shortest distance values](algo/step04.png "Shortest distance from values")

#### Next Step : neighbors of Tournai
Multiple paths, previous distances are compared, only shortest distances are `saved`.
<br>
```Ruby
visited = [:bruges,:ghent,:brussels,:antwerp,:tournai]
unvisited = [:mechelen,:mons,:namur,:liege,:arlon]
```
![Shortest distance from Bruges](algo/graph05.png "Shortest distance from Bruges")
![Shortest distance values](algo/step05.png "Shortest distance from values")

#### Next Step : neighbors of Mechelen
Multiple paths, previous distances are compared, only shortest distances are `saved`.
<br>
```Ruby
visited = [:bruges,:ghent,:brussels,:antwerp,:tournai,:mechelen]
unvisited = [:mons,:namur,:liege,:arlon]
```
![Shortest distance from Bruges](algo/graph06.png "Shortest distance from Bruges")
![Shortest distance values](algo/step06.png "Shortest distance from values")

#### Next Step : neighbors of Mons
Multiple paths, previous distances are compared, only shortest distances are `saved`.
<br>
```Ruby
visited = [:bruges,:ghent,:brussels,:antwerp,:tournai,:mechelen,:mons]
unvisited = [:namur,:liege,:arlon]
```
![Shortest distance from Bruges](algo/graph07.png "Shortest distance from Bruges")
![Shortest distance values](algo/step07.png "Shortest distance from values")

#### Last Step : neighbors of Liege
Multiple paths, previous distances are compared, only shortest distances are `saved`.
<br>
```Ruby
visited = [:bruges,:ghent,:brussels,:antwerp,:tournai,:mechelen,:mons,:liege]
unvisited = [:namur,:arlon]
```
![Shortest distance from Bruges](algo/graph08.png "Shortest distance from Bruges")
![Shortest distance values](algo/step08.png "Shortest distance from values")

### Conclusion
- For every request, each city with the shortest distance is visited.
- Starting from the *source* city to the *destination* city
- When a city is visited, all its direct neighbors will be visited (in order of ascending distances)
- Each distance is `checked`.
- Every distances are compared to each other.
- Only the shortest distance is `saved`
- For each visited city, the previous city with the shortest distance is `saved`
- The shortest path regroups all the *previous* cities between *destination* and *source* 
