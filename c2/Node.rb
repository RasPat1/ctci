class Node
  attr_accessor :value, :next_node

  def initialize(value, next_node = nil)
    @value = value
    @next_node = next_node
  end

  def self.list_from_array(arr)
    last_node = nil

    arr.reverse.each do |value|
      last_node = Node.new(value, last_node)
    end

    last_node
  end

  def size
    return 1 if next_node == nil
    1 + next_node.size
  end

  def append_to_end(node)
    append_to = self

    while append_to.next_node != nil
      append_to = append_to.next_node
    end

    append_to.next_node = node
  end

  def delete_node(value)
    head = self
    node = self

    # Delete head of list
    if head.value == value
      head = head.next_node
      return head
    end

    # iterate through the list until we
    # find the value to delete
    while node.next_node != nil
      if node.next_node.value == value
        node_to_delete = node.next_node
        node.next_node = node_to_delete.next_node
        break
      end
      node = node.next_node
    end

    head
  end

  def to_s
    "#{value} => #{next_node}"
  end
end