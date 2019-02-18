require './Graph.rb'
require './GraphNode.rb'
require 'byebug'

# Build Order: You are given a list of projects and a list of dependencies (which is a list of pairs of projects, where the second project is dependent on the first project). All of a project's dependencies must be built before the project is. Find a build order that will allow the projects to be built. If there is no valid build order, return an error.
# EXAMPLE
# Input:
# projects: a, b, c, d, e, f
# dependencies: (a, d), (f, b), (b, d), (f, a), (d, c)
# Output: f, e, a, b, d, c
# Hints: #26, #47, #60, #85, #725, #133

class BuildOrder
  def call(node_values, deps)
    g = Graph.new
    node_dict = {}

    node_values.each do |node_value|
      node = GraphNode.new(node_value)
      node_dict[node_value] = node
      g.add_node(node)
    end

    deps.each do |dep|
      project_1 = node_dict[dep[0]]
      project_2 = node_dict[dep[1]]

      project_2.add_edge(project_1)
    end

    build_order = []
    visited = {}


    # We could delete the node instead?
    # there may be multiple edges pointing to it
    # Maybe we'd have to architect our graph node a little diff
    # So we can do efficient deletes of the 1Direction edge
    # maybe just augment the node to have a visited value on it
    # and then just skip those in teh build step
    # This is all roughly the same complexity - consnta factors

    # This approach seems reasonable
    # O(V + E) space Our graph representation is doing that
    # O(V) space for our build list, and visited hash table
    # O(V + E) time.

    g.nodes.each do |node|
      build(node, build_order, visited)
    end

    build_order.join(",")
  end

  def build(node, build_order, visited)
    return [] if visited[node.value] == true # O(n) space

    node.nodes.each do |dep|
      build(dep , build_order, visited)
    end

    visited[node.value] = true
    build_order << node.value
    build_order
  end
end







class BuildOrder2
  def call(nodes, deps)
    graph = Graph.new(nodes)
    build_graph(graph, deps)

    build_order = []

    add_zero_dep_nodes(graph.nodes, build_order)

    build_pointer = 0

    while build_pointer < nodes.size
      node_to_process = build_order[build_pointer]
      return "No valid build order" if node_to_process == nil

      graph.remove_node(node_to_process.value)
      if node_to_process == build_order.last
        add_zero_dep_nodes(graph.nodes, build_order)
      end

      build_pointer += 1
    end

    build_order.map{ |node| node.value }.join(',')
  end

  def build_graph(graph, deps)
    deps.each do |edge|
      from = graph.get(edge[0])
      to = graph.get(edge[1])
      from.add_edge(to)
    end
  end

  def add_zero_dep_nodes(nodes, build_order)
    nodes.each do |node|
      build_order << node if node.incoming_count == 0
    end
  end

  class Node
    attr_accessor :incoming_count, :outgoing, :value

    def initialize(value)
      @value = value
      @incoming_count = 0
      @outgoing = []
    end

    def add_edge(node)
      if !@outgoing.include?(node)
        @outgoing << node
        node.increment
      end
    end

    def remove_edge(node)
      if @outgoing.include?(node)
        @outgoing.delete(node)
        node.decrement
      end
    end

    def increment
      @incoming_count += 1
    end

    def decrement
      @incoming_count -= 1
    end

    def to_s
      value.to_s
    end
  end
  class Graph
    attr_accessor :nodes

    def initialize(nodes = [])
      @nodes = []
      @node_map = {}
      nodes.each do |node_value|
        add_node(node_value)
      end
    end

    def add_node(node_value)
      if @node_map[node_value] == nil
        node = Node.new(node_value)
        @nodes << node
        @node_map[node_value] = node
      end
    end

    def remove_node(node_value)
      node = @node_map.delete(node_value)
      if node
        @nodes.delete(node)
        node.outgoing.each do |outgoing|
          outgoing.incoming_count -= 1
        end
      end
    end

    def get(node_value)
      @node_map[node_value]
    end
  end
end









all_nodes = ['a', 'b', 'c', 'd', 'e', 'f']
deps = [
  ['a', 'd'],
  ['f', 'b'],
  ['b', 'd'],
  ['f', 'a'],
  ['d', 'c']]
dep_2 = [
  ['f', 'c'],
  ['f', 'a'],
  ['f', 'b'],
  ['b', 'e'],
  ['a', 'e'],
  ['d', 'g'],
  ['c', 'a'],
  ['b', 'a']]
dep_3 = [
  ['a', 'b'],
  ['b', 'c'],
  ['c', 'a'],
  ['e', 'f'],
]
puts BuildOrder2.new.call(all_nodes, deps)
puts BuildOrder2.new.call(all_nodes << 'g', dep_2)
puts BuildOrder2.new.call(all_nodes, dep_3)

# OOoky
# Let's make a graph and then put each of the nodes along with an
# edge from node1 to node 2 in teh graph
# Then let's do a DFS, yeah DFS, making sure we hit each node
# and then porint out the build order
# This is a DAG with a topo sort basically