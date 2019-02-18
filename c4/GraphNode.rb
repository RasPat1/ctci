class GraphNode
  attr_accessor :nodes, :value

  def initialize(value)
    @value = value
    @nodes = []
  end

  # Directed edge
  def add_edge(node)
    @nodes << node
    @nodes = @nodes.uniq
  end
end