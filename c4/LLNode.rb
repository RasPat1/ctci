class LLNode
  attr_accessor :value, :next

  def initialize(value, next_node = nil)
    @value = value
    @next = next_node
  end

  def add_to_tail(node)
    tail_node = self

    while tail_node.next != nil
      tail_node = tail_node.next
    end

    tail_node.next = node
  end
end