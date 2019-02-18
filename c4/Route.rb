require './Graph.rb'
require './GraphNode.rb'

# Route Between Nodes
# Given a directed graph, design an algorithm to find out whether there is a route between two nodes.

class Route
  # ALgorithm!
  # Do a DFS or BFS from each node to find the other node
  # BFS (do it twice)
  # => Queue up all the nodes that are adjacent to the source in each step
  # Let's say do DFS from each node until we find a path
  # Runtime: O(V)
  # Memory: O(V)

  def initialize(graph, node1, node2)
    @graph = graph
    @node1 = node1
    @node2 = node2
  end

  def call
    # BFS(@node1, @node2) || BFS(@node2, @node1)

    DFS(@node1, @node2) || DFS(@node2, @node1)
  end

  # Find a path from the from_node to the to_node using
  # Breadth-first search
  def BFS(from, to)
    visited = {}
    q = []
    q.push(from)

    while q.size > 0
      node = q.shift
      visited[node] = true
      return true if node == to
      node.nodes.each do |neighbor|
        q.push(neighbor) unless visited[neighbor]
      end
    end

    false
  end

  def DFS(from, to, visited = {})
    return true if from == to
    visited[from] = true

    from.nodes.each do |neighbor|
      next if visited[neighbor]
      if neighbor == to || DFS(neighbor, to, visited)
        return true
      end
    end

    false
  end
end

g = Graph.new
# nodes = []
# 5.times do |val|
#   nodes << GraphNode.new(val)
# end

# 6.times do |edge|
#   n1 = nodes.shuffle[0]
#   n2 = nodes.shuffle[0]
#   if n1 != n2
#     n1.add_edge(n2)
#   end
# end
# nodes.each do |node|
#   g.add_node(node)
# end

n1 = GraphNode.new(1)
n2 = GraphNode.new(2)
n3 = GraphNode.new(3)
n4 = GraphNode.new(4)
n1.add_edge(n2)
n1.add_edge(n4)
n3.add_edge(n2)
n2.add_edge(n3)

puts Route.new(g, n1, n3).call
puts Route.new(g, n4, n1).call
puts Route.new(g, n3, n4).call