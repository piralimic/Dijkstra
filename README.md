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
#### Step 0 : no city visited
Initialize the distance as infinite from start city.
<br>
Visited =[] unvisited=[bruges,ghent,antwerp,tournai,mechelen,brussels,mons,namur,liege,arlon]
![Shortest distance from Bruges](algo/graph0.png "Shortest distance from Bruges")
![Shortest distance values](algo/step0.png "Shortest distance from values")
#### Step 1 : neighbours of Bruges
![Shortest distance from Bruges](algo/graph1.png "Shortest distance from Bruges")
![Shortest distance values](algo/step1.png "Shortest distance from values")
#### Step 2 : neighbours of Ghent
![Shortest distance from Bruges](algo/graph2.png "Shortest distance from Bruges")
![Shortest distance values](algo/step2.png "Shortest distance from values")
#### Step 3 : neighbours of Brussels
![Shortest distance from Bruges](algo/graph3.png "Shortest distance from Bruges")
![Shortest distance values](algo/step3.png "Shortest distance from values")
#### Step 4 : neighbours of Tournai
![Shortest distance from Bruges](algo/graph4.png "Shortest distance from Bruges")
![Shortest distance values](algo/step4.png "Shortest distance from values")
#### Step 5 : neighbours of Mons
![Shortest distance from Bruges](algo/graph5.png "Shortest distance from Bruges")
![Shortest distance values](algo/step5.png "Shortest distance from values")
#### Step 6 : neighbours of Namur
![Shortest distance from Bruges](algo/graph6.png "Shortest distance from Bruges")
![Shortest distance values](algo/step6.png "Shortest distance from values")
#### Step 7 : neighbours of Liege
![Shortest distance from Bruges](algo/graph7.png "Shortest distance from Bruges")
![Shortest distance values](algo/step7.png "Shortest distance from values")
### Conclusion
- For every request, each city is visited.
- Each distance is `saved`.
- Every distance is compared to each other.
- Only the shortest distance between each city is `saved`
