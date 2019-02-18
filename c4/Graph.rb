require './GraphNode.rb'

class Graph
  attr_accessor :nodes
  def initialize
    @nodes = []
  end

  def add_node(node)
    @nodes.push(node)
  end
end