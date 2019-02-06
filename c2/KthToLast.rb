require './Node.rb'

# Implement an algorithm to find the kth to last
# element in a singly linked list

class KthToLast
  def call(node, k)
    return nil if node == nil

    p1 = node
    p2 = node

    k.times do
      return nil if p1 == nil
      p1 = p1.next_node
    end

    while p1.next_node != nil
      p1 = p1.next_node
      p2 = p2.next_node
    end

    return p2.value
  end

  def call2(node, k)
    return -1 if node == nil

    index = call2(node.next_node, k) + 1

    if index == k
      puts node.value
    end

    return index
  end
end

ll = Node.new(3)
[4,5,6,7,8,2,3,4,7].each do |val|
  ll.append_to_end(Node.new(val))
end

puts "List: #{ll}"
puts "Size: #{ll.size}"
ll.size.times do |k|
  puts "For #{k}: #{KthToLast.new.call(ll, k)}"
end

puts "For Out of bounds: #{KthToLast.new.call(ll, 11)}"