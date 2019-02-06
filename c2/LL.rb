class LL
  attr_accessor :head, :tail
  def initialize
    @head = nil
    @tail = nil
  end

  def append(node)
    if self.head == nil
      self.head = node
      self.tail = node
    else
      self.tail.next_node = node
      self.tail = node
    end
  end

  def append_to_start(node)
    if self.head == nil
      self.head = node
      self.tail = node
    else
      node.next_node = self.head
      self.head = node
    end
  end
end