#ruby 2.3.1 recomended
class Graph
  attr_reader :graph, :nodes, :previous, :distance #getter methods
  INFINITY = 1 << 64 # same as 2**64

  def initialize
    @graph = {} # the graph // {node => { edge1 => weight, edge2 => weight}, node2 => ...
    @nodes = Array.new
  end

# connect each node with target and weight
  def connect_graph(source, target, weight)
    # if 'graph' still not have 'source' as key
    if (!graph.has_key?(source))
      # create new key 'source'
      # assign sub-key 'target' with 'weight' as value
      graph[source] = {target => weight}
    else
      # graph already have 'source' as key
      # create new-sub 'target' with 'weight' as value
      graph[source][target] = weight
    end
    # if 'nodes' list still not have 'source' as element
    if (!nodes.include?(source))
      # add 'source' to 'nodes' list
      nodes << source
    end
  end

# connect each node bidirectional
  def add_edge(source, target, weight)
    connect_graph(source, target, weight) #directional graph
    connect_graph(target, source, weight) #non directed graph (inserts the other edge too)
  end


# based of wikipedia's pseudocode: http://en.wikipedia.org/wiki/Dijkstra's_algorithm


  def dijkstra(source, dest)
    @distance={}
    @previous={}
    nodes.each do |node|#initialization
      @distance[node] = INFINITY #Unknown distance from source to vertex
      @previous[node] = -1 #Previous node in optimal path from source
    end

    @distance[source] = 0 #Distance from source to source

    #All nodes initially in Q (unvisited nodes)
    unvisited_node = nodes.compact # compact() returns a copy of self with all 'nil' elements removed.

    # perform while all the 'nodes' have not been visited
    while (unvisited_node.size > 0)
      # stop performing if the destination city has already been visited
      if (!unvisited_node.include?(dest))
        break
      end
      u = nil; # re-init 'u' on every loop

      # for each 'unvisited node'
      unvisited_node.each do |min|
        # if 'u' has no value OR 'distance' of current 'unvisited node' exist AND is smaller than 'distance' of 'u'
        if (not u) or (@distance[min] and @distance[min] < @distance[u])
          # assign current 'unvisited node' to 'u
          u = min
        end
      end

      # check if the current 'unvisited node' is not the 'source' then break the current loop and start next
      if (@distance[u] == INFINITY)
        break
      end

      # remove the current 'unvisited node' from the list
      unvisited_node = unvisited_node - [u]

      graph[u].keys.each do |vertex|
        alt = @distance[u] + graph[u][vertex]

        if (alt < @distance[vertex])
          @distance[vertex] = alt
          @previous[vertex] = u  #A shorter path to v has been found
        end

      end

    end

  end


# To find the full shortest route to a node

  def find_path(dest)
    if @previous[dest] != -1
      find_path @previous[dest]
    end
    @path << dest
  end


# Gets all shortests paths using dijkstra

  def shortest_paths(source, dest)
    @graph_paths=[]
    @source = source
    dijkstra(source, dest)

      @path=[]

      find_path dest

      actual_distance=if @distance[dest] != INFINITY
                        @distance[dest]
                      else
                        "no path"
                      end
      @graph_paths<< "#{@path.join(" > ")}"


    @graph_paths << actual_distance
    return @graph_paths
  end

  # print result

  def print_result
    @graph_paths.each do |graph|
      puts graph
    end
  end

end
