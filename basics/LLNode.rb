class LLNode
  attr_accessor :next_node, :value, :id
  @@id = -1

  def initialize(value, next_node)
    @next = next_node
    @value = value
    @@id += 1
    @id = @@id
  end

  def tail
    last_node = self

    while last_node.next_node != nil
      last_node = last_node.next_node
    end

    last_node
  end

  def to_s
    "#{value} => #{next_node == nil ? 'END' : next_node}"
  end
end

class LLNodeSpec
  def initialize
  end

  def test
    n3 = LLNode.new(10, nil)
    n2 = LLNode.new(12, nil)
    n1 = LLNode.new(20, nil)
    n3.next_node = n2
    n2.next_node = n1

    n3
  end
end

# puts LLNodeSpec.new.test